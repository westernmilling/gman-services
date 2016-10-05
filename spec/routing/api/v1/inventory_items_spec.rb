require 'rails_helper'

RSpec.describe Api::V1::Inventory::ItemsController,
               type: :routing do
  describe 'GET /api/v1/inventory/items' do
    it 'routes to the index action with json format' do
      expect(get: 'api/v1/inventory/items')
        .to route_to(
          controller: 'api/v1/inventory/items',
          action: 'index',
          format: 'json'
        )
    end
  end

  describe 'GET /api/v1/inventory/items.json' do
    it 'routes to the index action with json format' do
      expect(get: 'api/v1/inventory/items.json')
        .to route_to(
          controller: 'api/v1/inventory/items',
          action: 'index',
          format: 'json'
        )
    end
  end
  describe 'GET /api/v1/inventory/items_like_id_description' do
    it 'routes to the like_id_description action with json format' do
      expect(get: 'api/v1/inventory/items_like_id_description')
        .to route_to(
          controller: 'api/v1/inventory/items',
          action: 'like_id_description',
          format: 'json'
        )
    end
  end

  describe 'GET /api/v1/inventory/items_like_id_description.json' do
    it 'routes to the like_id_description action with json format' do
      expect(get: 'api/v1/inventory/items_like_id_description.json')
        .to route_to(
          controller: 'api/v1/inventory/items',
          action: 'like_id_description',
          format: 'json'
        )
    end
  end
  describe 'GET /api/v1/inventory/items_by_id' do
    it 'routes to the by_id action with json format' do
      expect(get: '/api/v1/inventory/items_by_id')
        .to route_to(
          controller: 'api/v1/inventory/items',
          action: 'by_id',
          format: 'json'
        )
    end
  end
  describe 'GET /api/v1/inventory/items_by_id.json' do
    it 'routes to the by_id action with json format' do
      expect(get: '/api/v1/inventory/items_by_id.json')
        .to route_to(
          controller: 'api/v1/inventory/items',
          action: 'by_id',
          format: 'json'
        )
    end
  end
end
