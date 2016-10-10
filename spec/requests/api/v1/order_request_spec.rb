require 'rails_helper'

describe '/api/v1/orders' do
  let(:order_references) do
    create_list(:order, 2).map do |order|
      waso_key = order.InOrd_WareShipToOrderKey

      order
        .lines << create(:order_line,
                         ItemId: Faker::Number.number(4),
                         InOrd_TotalPrice: Faker::Commerce.price,
                         InOrd_WareShipToOrderKey: waso_key)

      create(:order_reference,
             order: order,
             FeedXrefKey: order.OrderKey,
             OrderNumber: order.InOrd_OrderNo,
             ShipDate: order.InOrd_ShipDate,
             OrderStatusCd: order.InOrd_StatusCd,
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
          is_expected.to eq order_reference.order.InOrd_ShipTime.strftime('%H:%M')
        end
        its(['status']) do
          is_expected.to eq Order::STATUS_MAP[order_reference.OrderStatusCd].to_s
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

            its(['item_number']) do
              is_expected.to eq order_line.ItemId
            end
            its(['item_price']) do
              is_expected.to eq order_line.InOrd_TotalPrice.to_s
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
