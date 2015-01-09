require 'rails_helper'

RSpec.describe '/api/v1/all', :type => :request do
  let(:all) do
    DriverAdapter.all
  end

  it 'responds with drivers json' do
    response = doorkeeper_request.get('/api/v1/drivers')

    expect(response.body).to eq(all.to_json)
  end
end
