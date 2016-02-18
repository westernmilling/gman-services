require 'rails_helper'

RSpec.describe '/api/v1/commodity_merchandising/contracts', type: :request do
  let(:contracts) do
    create_list(:contract, 2)
  end
  let(:application) { create(:doorkeeper_application) }
  subject(:response) { oauth_get(url, application.uid, application.secret) }

  context 'when application id and secret are valid' do
    let(:application) { create(:doorkeeper_application) }
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

      its(:size) { is_expected.to eq 2 }

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
          is_expected.to eq contracts[0].CONT_ContractType
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
