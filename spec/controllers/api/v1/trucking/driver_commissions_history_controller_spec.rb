require 'rails_helper'

RSpec.describe Api::V1::Trucking::DriverCommissionsHistoryController,
               type: :controller do
  render_views

  before do
    allow(controller).to receive(:doorkeeper_token).and_return(token)
  end

  describe 'doorkeeper token' do
    context 'token accepted' do
      let(:token) { double acceptable?: true }
      it 'responds with 200' do
        get :index, format: :json
        expect(response.status).to eq(200)
      end
    end

    context 'token not accepted' do
      let(:token) do
        double acceptable?: false,
               accessible?: false
      end
      it 'responds with 401' do
        get :index, format: :json
        expect(response.status).to eq(401)
      end
    end
  end

  let(:driver_commission_history) do
    build_list(:driver_commission_history, 1, PaidDate: paid_date)
  end
  describe 'GET by_paid_date' do
    before do
      allow(DriverCommissionHistory)
        .to receive(:where)
        .with(PaidDate: paid_date)
        .and_return(driver_commission_history)

      get_by_paid_date
    end

    let(:token) { double acceptable?: true }
    let(:paid_date) { Date.new(2012, 1, 1) }
    let(:get_by_paid_date) do
      get :by_paid_date,
          format: :json,
          paid_date: paid_date
    end

    context 'when format is json' do
      it 'responds with 200' do
        expect(response.status).to eq(200)
      end
      it 'responds with json' do
        expect(response.content_type).to eq('application/json')
      end
      it 'body is not a null string' do
        expect(response.body).not_to eq('null')
      end
      it 'body is parseable JSON' do
        expect { JSON.parse(response.body) }.not_to raise_error
      end
      describe 'parsed JSON schema' do
        subject(:json) { JSON.parse(response.body, symbolize_names: true) }

        it 'is an array' do
          is_expected.to be_kind_of(Array)
        end
        describe 'first element' do
          subject { json.first }

          its(:keys) do
            is_expected.to eq([:back_hauls,
                               :customer_id,
                               :customer_name,
                               :delivery_date,
                               :driver_name,
                               :driver_number,
                               :driver_rate,
                               :driver_commission_history_key,
                               :freight_bill_number,
                               :freight_revenue,
                               :fuel_surcharge,
                               :layover,
                               :movement_cd,
                               :movement_type,
                               :other_hour_dollars,
                               :order_number,
                               :origin_name,
                               :paid_date,
                               :revenue,
                               :split_rate,
                               :total_freight_revenue])
          end
        end
      end
    end
  end
end
