require 'rails_helper'

RSpec.describe '/api/v1/all', :type => :request do
  let(:all) do
    DriverCommissionHistoryAdapter.all
  end

  let(:by_paid_date) do
    DriverCommissionHistoryAdapter.by_paid_date(Date.new(2012, 01, 01))
  end

  # rubocop:disable Metrics/LineLength,
  let(:all_url) { '/api/v1/driver_commissions_history' }
  let(:by_paid_date_url) { '/api/v1/driver_commissions_history_by_paid_date.json?paid_date=2012-01-01' }
  # rubocop:enable Metrics/LineLength

  context 'when application id and secret are valid' do
    let(:response) { doorkeeper_request.get(all_url) }
    let(:response_by_paid_date) { doorkeeper_request.get(by_paid_date_url) }

    it 'responds with all driver commission history json' do
      expect(response.body).to eq(all.to_json)
    end

    it 'responds with driver commission history by paid date json' do
      expect(response_by_paid_date.body).to eq(by_paid_date.to_json)
    end
  end

  context 'when application id and secret are not valid' do
    # response = token.get(all_url))
    # response = token.get(by_paid_date_url)

    # it { expect(response.status).to eq('401') }
  end

  context 'when application id and secret are not present' do
    let(:response) { get(all_url) }
    let(:response_by_paid_date) { get(by_paid_date_url) }

    it 'fail all driver commission histories with 401' do
      expect(response).to eq(401)
    end
    it 'fail driver commission histories by paid date with 401' do
      expect(response_by_paid_date).to eq(401)
    end
  end
end
