require 'rails_helper'

RSpec.describe '/api/v1/commodity_merchandising/contracts', type: :request do
  let(:contracts) do
    Array.new(10) do
      create(:contract, LocationId: [1, 2, 3, 4].sample)
    end
  end
  let(:application) { create(:doorkeeper_application) }
  let(:query_string) { '' }
  let(:request) { oauth_get(url, application.uid, application.secret) }
  let(:response) { request.response }
  let(:url) { "/api/v1/commodity_merchandising/contracts#{query_string}" }

  context 'when there are no filters' do
    subject(:response) do
      contracts

      oauth_get('/api/v1/commodity_merchandising/contracts',
                application.uid,
                application.secret)
    end
    it 'response should have status equal to 200' do
      expect(response.status).to eq(200)
    end
    describe 'response body' do
      let(:body) { response.body }
      subject { JSON.parse(response.body) }

      its(:size) { is_expected.to eq contracts.size }

      describe 'first contract' do
        let(:first) { JSON.parse(response.body)[0] }
        subject { JSON.parse(response.body)[0] }

        its(['contract_id']) do
          is_expected.to eq contracts[0].ContractId
        end
        its(['customer_id']) do
          is_expected.to eq contracts[0].CustomerId
        end
        its(['contract_number']) do
          is_expected.to eq contracts[0].CONT_ContractNumber
        end
        its(['commodity_id']) do
          is_expected.to eq contracts[0].CommodityId
        end
        its(['contract_id']) do
          is_expected.to eq contracts[0].ContractId
        end
        its(['contract_date']) do
          is_expected.to eq contracts[0].CONT_ContractDate.to_s(:iso8601)
        end
        its(['contract_type']) do
          is_expected.to eq contracts[0].contract_type
        end
        its(['inv_contract_id']) do
          is_expected.to eq contracts[0].Inv_ContractId
        end
        its(['location_id']) do
          is_expected.to eq contracts[0].LocationId
        end
        its(['price']) do
          is_expected.to eq contracts[0].CONT_Price
        end
        its(['freight_adjustment']) do
          is_expected.to eq contracts[0].CONT_FreightAdjustment
        end
        its(['quantity']) do
          is_expected.to eq contracts[0].CONT_Quantity
        end
        its(['delivered_quantity']) do
          is_expected.to eq contracts[0].CONT_DeliveredBushels
        end
        its(['from_date']) do
          is_expected.to eq contracts[0].CONT_FromDate.to_s(:iso8601)
        end
        its(['to_date']) do
          is_expected.to eq contracts[0].CONT_ToDate.to_s(:iso8601)
        end
        its(['commodity']) { is_expected.to be_present }
        its(['unit_of_measure']) { is_expected.to be_present }

        describe 'commodity' do
          subject { first['commodity'] }

          its(['commodity_id']) do
            is_expected.to eq contracts[0].commodity.CommodityId
          end
          its(['description']) do
            is_expected.to eq contracts[0].commodity.COMM_Description
          end
          its(['conversion_factor']) do
            is_expected.to eq contracts[0].commodity.COMM_ConversionFactor
          end
        end
        describe 'unit_of_measure' do
          subject { first['unit_of_measure'] }

          its(['uom_id']) do
            is_expected.to eq contracts[0].unit_of_measure.CommUOMId
          end
          its(['description']) do
            is_expected.to eq contracts[0].unit_of_measure.CommUOMDescription
          end
        end
      end
    end
  end

  context 'when filtering by contract_type_eq' do
    let(:filtered_contract_type) { %w(Purchase Sale).sample }
    let(:query_string) do
      "?q[contract_type_eq]=#{filtered_contract_type}"
    end

    it 'should respond with status code of 200' do
      expect(response.status).to eq(200)
    end

    it 'should return contracts matching the contract type' do
      parsed_body = JSON.parse(response.body)

      expect(parsed_body.map { |hash| hash['contract_type'] })
        .to all eq filtered_contract_type
    end
  end

  context 'when filtering by inv_contract_id_eq' do
    let(:filtered_inv_contract_id) { contracts.sample.Inv_ContractId }
    let(:query_string) do
      "?q[inv_contract_id_eq]=#{filtered_inv_contract_id}"
    end

    it 'should respond with status code of 200' do
      expect(response.status).to eq(200)
    end
    it 'should return a single contract' do
      parsed_body = JSON.parse(response.body)

      expect(parsed_body.size).to eq 1
    end

    it 'should return a contract matching inventory contract id' do
      parsed_body = JSON.parse(response.body)

      expect(parsed_body[0]['inv_contract_id']).to eq filtered_inv_contract_id
    end
  end

  context 'when filtering by location_id_eq' do
    let(:filtered_location_id) { contracts.sample.LocationId }
    let(:query_string) do
      "?q[location_id_eq]=#{filtered_location_id}"
    end

    it 'should respond with status code of 200' do
      expect(response.status).to eq(200)
    end
    it 'should return contracts matching the location id' do
      parsed_body = JSON.parse(response.body)

      expect(parsed_body.map { |hash| hash['location_id'] })
        .to all eq filtered_location_id
    end
  end

  context 'when application id and secret are not valid' do
    subject(:response) do
      oauth_get('/api/v1/commodity_merchandising/contracts', '1', '1')
    end

    it 'response should have status equal to 401' do
      expect(response.status).to eq(401)
    end

    it 'response should have blank body' do
      expect(response.body).to be_blank
    end
  end

  context 'when application id and secret are not present' do
    subject(:response) do
      get('/api/v1/commodity_merchandising/contracts')
    end

    it 'response should have status equal to 401' do
      expect(response).to eq(401)
    end
  end
end
