require 'rails_helper'

describe 'pick up orders' do
  let(:application) { create(:doorkeeper_application) }

  describe 'GET index' do
    before do
      pick_up_orders
    end

    let(:contracts) do
      [
        create(:contract),
        create(:contract)
      ]
    end
    let(:pick_up_orders) do
      Array.new(10) do |i|
        contract = contracts[i % 2]

        create(:pick_up_order,
               ContractId: contract.Inv_ContractId,
               ContractLocationId: contract.LocationId)
      end
    end
    let(:query_string) { '' }
    let(:request) { oauth_get(url, application.uid, application.secret) }
    let(:response) { request.response }
    let(:url) { "/api/v1/pick_up_orders#{query_string}" }

    context 'when filtered by commodity id' do
      let(:filtered_commodity_id) { pick_up_orders.sample.contract.CommodityId }
      let(:query_string) do
        "?q[contract_commodity_id_eq]=#{filtered_commodity_id}"
      end

      it 'should respond with status code of 200' do
        expect(response.status).to eq(200)
      end
      it 'should only return pick up orders for the filtered commodity id' do
        parsed_body = JSON.parse(response.body)

        expect(parsed_body.map { |hash| hash['contract']['commodity_id'] })
          .to all eq filtered_commodity_id
      end
    end
  end
end
