require 'rails_helper'

RSpec.describe Api::V1::Trucking::DriverCommissionsHistoryController,
               type: :routing do
  describe 'GET /api/v1/driver_commissions_history' do
    it 'routes to the index action with json format' do
      expect(get: '/api/v1/driver_commissions_history')
        .to route_to(
          controller: 'api/v1/trucking/driver_commissions_history',
          action: 'index',
          format: 'json'
        )
    end
  end

  describe 'GET /api/v1/driver_commissions_history.json' do
    it 'routes to the index action with json format' do
      expect(get: '/api/v1/driver_commissions_history.json')
        .to route_to(
          controller: 'api/v1/trucking/driver_commissions_history',
          action: 'index',
          format: 'json'
        )
    end
  end
  describe 'GET /api/v1/driver_commissions_history_by_paid_date' do
    it 'routes to the by_paid_date action with json format' do
      expect(get: '/api/v1/driver_commissions_history_by_paid_date')
        .to route_to(
          controller: 'api/v1/trucking/driver_commissions_history',
          action: 'by_paid_date',
          format: 'json'
        )
    end
  end

  describe 'GET /api/v1/driver_commissions_history_by_paid_date.json' do
    it 'routes to the by_paid_date action with json format' do
      expect(get: '/api/v1/driver_commissions_history_by_paid_date.json')
        .to route_to(
          controller: 'api/v1/trucking/driver_commissions_history',
          action: 'by_paid_date',
          format: 'json'
        )
    end
  end
end
