require 'rails_helper'

describe '/api/v1/orders' do
  let(:order_references) do
    create_list(:order, 2).each_with_index.map do |order, index|
      waso_key = order.InOrd_WareShipToOrderKey

      order
        .lines << create(:order_line,
                         OrderKey: order.OrderKey.to_s + '00',
                         ItemId: Faker::Number.number(4),
                         InOrd_GrossInvoiceAmount: 10_000,
                         InOrd_InvoiceDate: Time.zone.today,
                         InOrd_Invoice: 100_000 + index,
                         InOrd_TotalPrice: Faker::Commerce.price,
                         InOrd_WareShipToOrderKey: waso_key)

      create(:order_reference,
             order: order,
             FeedXrefKey: order.OrderKey,
             OrderNumber: order.InOrd_OrderNo,
             OrderStatusCd: order.InOrd_StatusCd,
             ShipDate: order.InOrd_ShipDate,
             WarehouseId: order.WarehouseId)
    end
  end
  let(:application) { create(:doorkeeper_application) }

  describe 'GET show' do
    context 'when a matching order can be found' do
      before do
        order_references
      end
      let(:order_reference) { order_references.sample }
      let(:response) do
        oauth_get("/api/v1/orders/#{order_reference.UuidHeader}",
                  application.uid,
                  application.secret)
          .response
      end

      subject { response }

      let(:response_body) { JSON.parse(response.body) }

      it 'response should have status equal to 200' do
        expect(subject.status).to eq(200)
      end
      describe 'response body' do
        subject { JSON.parse(response.body) }

        its(['order_number']) do
          is_expected.to eq order_reference.OrderNumber
        end
        its(['order_key']) do
          is_expected.to eq order_reference.order.OrderKey
        end
        its(['carrier_id']) do
          is_expected.to eq order_reference.order.carrier_id
        end
        its(['quantity_shipped']) do
          is_expected.to eq order_reference.order.quantity_shipped
        end
        its(['ship_date']) do
          is_expected.to eq order_reference.ShipDate.to_date.to_s(:iso8601)
        end
        its(['ship_time']) do
          is_expected
            .to eq order_reference.order.InOrd_ShipTime.strftime('%H:%M')
        end
        its(['status']) do
          is_expected
            .to eq Order::STATUS_MAP[order_reference.OrderStatusCd].to_s
        end
        its(['warehouse_id']) do
          is_expected.to eq order_reference.WarehouseId
        end
        its(['uuid']) do
          is_expected.to eq order_reference.UuidHeader
        end

        describe 'lines' do
          subject { response_body['lines'] }

          its(:size) { is_expected.to eq order_reference.order.lines.size }

          describe 'lines[0]' do
            let(:order_line) { order_reference.order.lines[0] }

            subject { response_body['lines'][0] }

            its(['invoice_date']) do
              is_expected
                .to eq order_line.InOrd_InvoiceDate.to_date.to_s(:iso8601)
            end
            its(['invoice_gross_amount']) do
              is_expected.to eq order_line.InOrd_GrossInvoiceAmount.to_s
            end
            its(['invoice_number']) do
              is_expected.to eq order_line.InOrd_Invoice
            end
            its(['item_number']) do
              is_expected.to eq order_line.ItemId
            end
            its(['item_price']) do
              is_expected.to eq order_line.InOrd_TotalPrice.to_s
            end

            describe 'contract' do
              subject { response_body['lines'][0]['contract'] }

              context 'when the order line does not have a contract applied' do
                it { is_expected.to be_nil }
              end

              context 'when the order line has a contract applied' do
                let(:order_reference) do
                  order_references.sample.tap do |reference|
                    contract = create(:contract, CONT_ContractType: 'S')

                    reference.order.lines[0].update_attributes!(
                      ContractId: contract.Inv_ContractId
                    )
                  end
                end

                it { is_expected.to be_present }
                its(['contract_date']) do
                  is_expected
                    .to eq order_line.contract.CONT_ContractDate.to_s(:iso8601)
                end
                its(['contract_id']) do
                  is_expected.to eq order_line.contract.ContractId
                end
                its(['contract_price']) do
                  is_expected.to eq order_line.contract.CONT_Price
                end
                its(['contract_number']) do
                  is_expected.to eq order_line.contract.CONT_ContractNumber
                end
                its(['contract_sub']) do
                  is_expected.to eq order_line.contract.CONT_ContractSub
                end
                its(['contract_type']) do
                  is_expected.to eq order_line.contract.contract_type
                end
                its(['fob_location']) do
                  is_expected.to eq order_line.contract.fob_location
                end
                its(['location_id']) do
                  is_expected.to eq order_line.contract.LocationId
                end
              end
            end
          end
        end
      end
    end

    context 'when no matching order can be found' do
      let(:uuid) { SecureRandom.uuid }
      let(:response) do
        oauth_get("/api/v1/orders/#{uuid}",
                  application.uid,
                  application.secret)
          .response
      end

      subject { response }

      it 'response should have status equal to 404' do
        expect(subject.status).to eq(404)
      end
    end
  end
end
