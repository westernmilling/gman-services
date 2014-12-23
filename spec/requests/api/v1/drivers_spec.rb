require 'rails_helper'

RSpec.describe '/api/v1/drivers', :type => :request do
  let(:drivers) do
    DriverAdapter.drivers
  end

  it 'responds with drivers json' do
    get '/api/v1/drivers'

    expect(response.body).to eq(drivers.to_json)
  end
end
