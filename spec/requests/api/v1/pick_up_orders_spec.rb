require 'rails_helper'

describe 'pick up orders' do
  let(:application) { create(:doorkeeper_application) }

  describe 'GET index' do
    before do
      pick_up_orders
    end

    let(:commodities) do
      [
        create(:commodity, CommodityId: 1001),
        create(:commodity, CommodityId: 1002)
      ]
    end
    let(:contracts) do
      [
        create(:contract, commodity: items[0].commodity),
        create(:contract, commodity: items[1].commodity)
      ]
    end
    let(:items) do
      [
        create(:inventory_item, InItem_CommodityId: commodities[0].CommodityId),
        create(:inventory_item, InItem_CommodityId: commodities[1].CommodityId)
      ]
    end
    let(:pick_up_order_count) { 10 }
    let(:pick_up_orders) do
      Array.new(pick_up_order_count) do |i|
        contract = contracts[i % 2]
        item = items[i % 2]

        create(:pick_up_order,
               ContractId: contract.Inv_ContractId,
               ContractLocationId: contract.LocationId,
               ItemId: item.ItemId,
               LoadNumber: i,
               PurchaseCustomerId: contract.CustomerId,
               ReleasePrefix: contract.Inv_ContractId,
               ReleaseLoadNumber: i)
      end
    end
    let(:filters) { {} }
    let(:query_string) do
      filters.map { |key, value| "q[#{key}]=#{value}" }
             .join('&')
             .tap { |string| string.present? ? string.prepend('?') : string }
    end
    let(:request) { oauth_get(url, application.uid, application.secret) }
    let(:response) { request.response }
    let(:url) { "/api/v1/pick_up_orders#{query_string}" }

    context 'when the request has no filtering parameters' do
      let(:pick_up_order_count) { 1 }

      include_examples 'response ok'

      it 'should return pick up orders' do
        parsed_body = JSON.parse(response.body)

        expect(parsed_body[0]['contract_id'])
          .to eq(pick_up_orders[0].ContractId)
        expect(parsed_body[0]['contract_location_id'])
          .to eq(pick_up_orders[0].ContractLocationId)
        expect(parsed_body[0]['commodity_id'])
          .to eq(pick_up_orders[0].item.InItem_CommodityId)
        expect(parsed_body[0]['item_id'])
          .to eq(pick_up_orders[0].ItemId)
        expect(parsed_body[0]['load_number'])
          .to eq(pick_up_orders[0].LoadNumber)
        expect(parsed_body[0]['origin'])
          .to eq(pick_up_orders[0].Origin)
        expect(parsed_body[0]['origin_state'])
          .to eq(pick_up_orders[0].OriginState)
        expect(parsed_body[0]['origin_gross_weight'])
          .to eq(pick_up_orders[0].OriginGrossWeight)
        expect(parsed_body[0]['origin_net_weight'])
          .to eq(pick_up_orders[0].OriginNetWeight)
        expect(parsed_body[0]['origin_tare_weight'])
          .to eq(pick_up_orders[0].OriginTareWeight)
        expect(parsed_body[0]['origin_weight_certificate'])
          .to eq(pick_up_orders[0].OriginWeightCertificate)
        expect(parsed_body[0]['pickup_type'])
          .to eq(pick_up_orders[0].pickup_type)
        expect(parsed_body[0]['purchase_customer_id'])
          .to eq(pick_up_orders[0].PurchaseCustomerId.to_s)
        expect(parsed_body[0]['release_prefix'])
          .to eq(pick_up_orders[0].ReleasePrefix)
        expect(parsed_body[0]['release_load_number'])
          .to eq(pick_up_orders[0].ReleaseLoadNumber)
        expect(parsed_body[0]['release_number'])
          .to eq(pick_up_orders[0].release_number)
        expect(parsed_body[0]['ship_date'])
          .to eq(pick_up_orders[0].ShipDate.to_s(:iso8601))
        expect(parsed_body[0]['status'])
          .to eq(pick_up_orders[0].status)
      end
    end

    context 'when the request is filtering by commodity id' do
      let(:filters) do
        {
          item_commodity_id_eq: pick_up_orders.sample.item.InItem_CommodityId
        }
      end

      it 'should only return matching records' do
        parsed_body = JSON.parse(response.body)

        expect(parsed_body.map { |hash| hash['commodity_id'] })
          .to all eq filters[:item_commodity_id_eq].to_i
      end
    end

    context 'when the request is filtering by contract id' do
      let(:filters) do
        {
          contract_id_eq: pick_up_orders.sample.ContractId
        }
      end

      it 'should only return matching records' do
        parsed_body = JSON.parse(response.body)

        expect(parsed_body.map { |hash| hash['contract_id'] })
          .to all eq filters[:contract_id_eq]
      end
    end

    context 'when the request is filtering by purchase customer id' do
      let(:filters) do
        {
          purchase_customer_id_eq: pick_up_orders.sample.PurchaseCustomerId
        }
      end

      it 'should only return matching records' do
        parsed_body = JSON.parse(response.body)

        expect(parsed_body.map { |hash| hash['purchase_customer_id'] })
          .to all eq filters[:purchase_customer_id_eq].to_s
      end
    end

    context 'when the request is filtering by release number' do
      let(:filters) do
        {
          release_number_eq: pick_up_orders.sample.release_number
        }
      end

      it 'should only return matching records' do
        parsed_body = JSON.parse(response.body)

        expect(parsed_body).to_not be_empty
        expect(parsed_body.map { |hash| hash['release_number'] })
          .to all eq filters[:release_number_eq]
      end
    end

    context 'when the request is filtering by contract balance equal' do
      let(:balance) { pick_up_orders.sample.contract.balance }
      let(:matching_pick_up_orders) do
        pick_up_orders.select do |pick_up|
          pick_up.contract.balance == balance
        end
      end
      let(:filters) do
        {
          contract_balance_eq: balance
        }
      end

      it 'should only return matching records' do
        parsed_body = JSON.parse(response.body)

        expect(parsed_body).to_not be_empty
        expect(
          parsed_body
            .map { |hash| "#{hash['contract_id']}-#{hash['load_number']}" }
        ).to contain_exactly(
          *matching_pick_up_orders
            .map { |match| "#{match.ContractId}-#{match.LoadNumber}" }
        )
      end
    end

    context 'when the request is filtering by contract balance greater than' do
      let(:balance) { contracts[0].balance }
      let(:contracts) do
        [
          create(:contract,
                 commodity: items[0].commodity,
                 CONT_Quantity: 1_000,
                 CONT_DeliveredBushels: 0),
          create(:contract,
                 commodity: items[1].commodity,
                 CONT_Quantity: 2_000,
                 CONT_DeliveredBushels: 0)
        ]
      end
      let(:matching_pick_up_orders) do
        pick_up_orders.select do |pick_up|
          pick_up.contract.balance > balance
        end
      end
      let(:pick_up_order_count) { 2 }
      let(:filters) do
        {
          contract_balance_gt: balance
        }
      end

      it 'should only return matching records' do
        parsed_body = JSON.parse(response.body)

        expect(parsed_body).to_not be_empty
        expect(
          parsed_body
            .map { |hash| "#{hash['contract_id']}-#{hash['load_number']}" }
        ).to contain_exactly(
          *matching_pick_up_orders
            .map { |match| "#{match.ContractId}-#{match.LoadNumber}" }
        )
      end
    end

    context 'when the request is filtering by contract balance less than' do
      let(:balance) { contracts[1].balance }
      let(:contracts) do
        [
          create(:contract,
                 commodity: items[0].commodity,
                 CONT_Quantity: 1_000,
                 CONT_DeliveredBushels: 0),
          create(:contract,
                 commodity: items[1].commodity,
                 CONT_Quantity: 2_000,
                 CONT_DeliveredBushels: 0)
        ]
      end
      let(:matching_pick_up_orders) do
        pick_up_orders.select do |pick_up|
          pick_up.contract.balance < balance
        end
      end
      let(:pick_up_order_count) { 2 }
      let(:filters) do
        {
          contract_balance_lt: balance
        }
      end

      it 'should only return matching records' do
        parsed_body = JSON.parse(response.body)

        expect(parsed_body).to_not be_empty
        expect(
          parsed_body
            .map { |hash| "#{hash['contract_id']}-#{hash['load_number']}" }
        ).to contain_exactly(
          *matching_pick_up_orders
            .map { |match| "#{match.ContractId}-#{match.LoadNumber}" }
        )
      end
    end

    context 'when the request is filtering by contract balance not equal' do
      let(:filters) do
        {
          contract_balance_not_eq: pick_up_orders.sample.contract.balance
        }
      end

      it 'should only not return matching records' do
        parsed_body = JSON.parse(response.body)

        expect(parsed_body).to_not be_empty
        expect(parsed_body.map { |hash| hash['contract_balance'] })
          .to_not contain_exactly filters[:contract_balance_not_eq].to_i
      end
    end
  end
end
