require 'rails_helper'

RSpec.describe '/api/v1/drivers', type: :request do
  let(:all) do
    DriverAdapter.all
  end

  context 'when application id and secret are valid' do
    let(:application) { create(:doorkeeper_application) }
    subject(:response) do
      oauth_get('/api/v1/drivers', application.uid, application.secret)
    end
    it 'response should have status equal to 200' do
      expect(response.status).to eq(200)
    end
    it 'have a body equal to all drivers json' do
      expect(response.body).to eq(all.to_json)
    end
  end

  context 'when application id and secret are not valid' do
    subject(:response) do
      oauth_get('/api/v1/drivers', '1', '1')
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
      get('/api/v1/drivers')
    end

    it 'response should have status equal to 401' do
      expect(response).to eq(401)
    end
  end
end
