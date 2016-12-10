require 'rails_helper'

describe '/api/v1/customer_contracts' do
  let(:application) { create(:doorkeeper_application) }

  describe 'GET index' do
    let(:query_string) do
    end
    let(:response) do
      oauth_get("/api/v1/customer_contracts/#{query_string}",
                application.uid,
                application.secret)
        .response
    end

    subject { response }

    context 'when there are contracts for the customers' do
      it 'response should have status equal to 200' do
        expect(subject.status).to eq 200
      end

      describe 'response body' do
        subject { JSON.parse(response.body) }

        pending 'expect the body to contain the customer contracts'
      end
    end

    context 'when there are no contracts for the customers' do
      let(:response_body) { JSON.parse(response.body) }

      it 'response should have status equal to 200' do
        expect(subject.status).to eq 200
      end

      describe 'response body' do
        subject { JSON.parse(response.body) }

        pending 'expect the body to be empty'
      end
    end
  end
end
