require 'rails_helper'

RSpec.describe '/api/v1/all', :type => :request do
  let(:all) do
    DriverAdapter.all
  end
  context 'when application id and secret are valid' do
    subject(:response) { doorkeeper_request.get('/api/v1/drivers') }
    it 'responds with drivers json' do
      expect(response.body).to eq(all.to_json)
    end
  end

  context 'when application id and secret are not valid' do
    # response = token.get(all_url))
    # response = token.get(by_paid_date_url)

    # it { expect(response.status).to eq('401') }
  end

  context 'when application id and secret are not present' do
    subject(:response) { get('/api/v1/drivers') }

    it 'fail all drivers with 401' do
      is_expected.to eq(401)
    end
  end
end
