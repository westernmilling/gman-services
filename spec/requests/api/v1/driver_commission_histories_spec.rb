require 'rails_helper'

RSpec.describe '/api/v1/all', :type => :request do
  let(:all) do
    DriverCommissionHistoryAdapter.all
  end

  let(:by_paid_date) do
    DriverCommissionHistoryAdapter.by_paid_date(Date.new(2012, 01, 01))
  end

  it 'responds with all driver commission history json' do
    response = doorkeeper_request.get('/api/v1/driver_commissions_history')

    expect(response.body).to eq(all.to_json)
  end

  it 'responds with driver commission history by paid date json' do
    # rubocop:disable Metrics/LineLength,
    response = doorkeeper_request.get('/api/v1/driver_commissions_history_by_paid_date.json?paid_date=2012-01-01')
    # rubocop:enable Metrics/LineLength
    expect(response.body).to eq(by_paid_date.to_json)
  end
end
