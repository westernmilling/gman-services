require 'rails_helper'

RSpec.describe Api::V1::OrdersController,
               type: :routing do
  describe 'GET /api/v1/orders' do
    it 'routes to the index action with json format' do
      expect(get: '/api/v1/orders')
        .to route_to(
          controller: 'api/v1/orders',
          action: 'index',
          format: 'json'
        )
    end
  end

  describe 'GET /api/v1/orders/:id.json' do
    it 'routes to the index action with json format' do
      expect(get: '/api/v1/orders/1')
        .to route_to(
          controller: 'api/v1/orders',
          action: 'show',
          id: '1',
          format: 'json'
        )
    end
  end
end
