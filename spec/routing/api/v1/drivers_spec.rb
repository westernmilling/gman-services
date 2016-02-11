require 'rails_helper'

RSpec.describe Api::V1::Trucking::DriversController, type: :routing do
  describe 'GET /api/v1/drivers' do
    it 'routes to the index action with json format' do
      expect(get: '/api/v1/drivers').to route_to(
        controller: 'api/v1/trucking/drivers',
        action: 'index', format: 'json')
    end
  end

  describe 'GET /api/v1/drivers.json' do
    it 'routes to the index action with json format' do
      expect(get: '/api/v1/drivers.json').to route_to(
        controller: 'api/v1/trucking/drivers',
        action: 'index', format: 'json')
    end
  end
end
