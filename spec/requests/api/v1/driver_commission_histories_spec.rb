require 'rails_helper'

RSpec.describe '/api/v1/driver_commission_history', type: :request do
  let(:application) { create(:doorkeeper_application)  }
  subject(:response) { oauth_get(url, application.uid, application.secret) }

  describe 'by_paid_date' do
    let(:by_paid_date) do
      DriverCommissionHistory.where(PaidDate: Date.new(2012, 1, 1))
    end

    # rubocop:disable Metrics/LineLength,
    let(:url) { '/api/v1/driver_commissions_history_by_paid_date.json?paid_date=2012-01-01' }
    # rubocop:enable Metrics/LineLength

    context 'when application id and secret are valid' do
      it 'response should have body equal to by_paid_date json' do
        expect(response.body).to eq(by_paid_date.to_json)
      end

      it 'response should have status equal to 200' do
        expect(response.status).to eq(200)
      end
    end

    context 'when application id and secret are not valid' do
      subject(:response) do
        oauth_get(url, '1', '1')
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
        get(url)
      end

      it 'response should have status equal to 401' do
        expect(response).to eq(401)
      end
    end
  end
end
