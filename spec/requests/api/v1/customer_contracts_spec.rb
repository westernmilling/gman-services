require 'rails_helper'

describe '/api/v1/customer_contracts' do
  let(:application) { create(:doorkeeper_application) }

  describe 'GET index' do
    before do
      customer_contracts
    end

    let(:contract) { create(:contract) }
    let(:customer) { create(:customer) }
    let(:query_string) do
      {
        customer_id: customer.CustomerId
      }
        .map { |k, v| "q[#{k}]=#{v}" }
        .join('&')
    end
    let(:response) do
      oauth_get("/api/v1/customer_contracts?#{query_string}",
                application.uid,
                application.secret)
        .response
    end

    subject { response }

    context 'when there are contracts for the customers' do
      let(:customer_contracts) do
        create_list(:customer_contract,
                    1,
                    ContractType: contract.CONT_ContractType,
                    CustomerId: customer.CustomerId,
                    InvContractId: contract.Inv_ContractId,
                    LocationId: contract.LocationId)
      end

      it 'response should have status equal to 200' do
        expect(subject.status).to eq 200
      end

      describe 'response body as json' do
        subject { JSON.parse(response.body) }

        its(:size) do
          is_expected.to eq 1
        end

        describe 'first element' do
          subject { JSON.parse(response.body)[0] }

          its(['contract_id']) do
            is_expected.to eq customer_contracts[0].InvContractId
          end
          its(['contract_type']) do
            is_expected.to eq customer_contracts[0].contract_type
          end
          its(['customer_id']) do
            is_expected.to eq customer_contracts[0].CustomerId.to_s
          end
          its(['location_id']) do
            is_expected.to eq customer_contracts[0].LocationId
          end
        end
      end
    end

    context 'when there are no contracts for the customers' do
      let(:customer_contracts) {}

      it 'response should have status equal to 200' do
        expect(subject.status).to eq 200
      end

      describe 'response body' do
        subject { JSON.parse(response.body) }

        it { is_expected.to be_empty }
      end
    end
  end
end
