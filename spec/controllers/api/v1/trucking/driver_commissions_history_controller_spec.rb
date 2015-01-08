require 'rails_helper'

RSpec.describe Api::V1::Trucking::DriverCommissionsHistoryController,
               :type => :controller do
  
  describe 'doorkeeper token' do
    before do
      allow(controller).to receive(:doorkeeper_token).and_return(token)
    end
    context 'token accepted' do
      let(:token) { double :acceptable? => true }
      it 'responds with 200' do
        get :index, :format => :html
        expect(response.status).to eq(200)
      end
    end

    context 'token not accepted' do
      let(:token) { double :acceptable? => false,
                           :accessible? => false }
      it 'responds with 401' do
        get :index, :format => :html
        expect(response.status).to eq(401)
      end
    end
  end
  
  let(:driver_commission_history) do
    [
      {
        :driver_id => Faker::Number.number(4),
        :backhauls => 'BACKHAULS',
        :freight_revenue => Faker::Number.number(4),
        :customer_id => 0001,
        :delivery_date => Date.new(2012, 01, 01),
        :driver_rate => Faker::Number.number(4),
        :freight_bill_number => Faker::Number.number(4),
        :fuel_revenue => Faker::Number.number(4),
        :fuel_surcharge => Faker::Number.number(4),
        :layover => 'layover',
        :movement_type => 'MOVE TYPE',
        :other_hour_dollars => Faker::Number.number(4),
        :order_number_text => Faker::Number.number(4),
        :origin_name => 'ORIGIN NAME',
        :paid_date => Date.new(2012, 01, 01),
        :revenue => Faker::Number.number(4),
        :split_rate => Faker::Number.number(4),
        :total_freight_revenue => Faker::Number.number(4)
      }
    ]
  end
  before do
    allow(DriverCommissionHistoryAdapter)
      .to receive(:all) { driver_commission_history }
    allow(DriverCommissionHistoryAdapter)
      .to receive(:by_paid_date) { driver_commission_history }
  end

  describe 'GET index' do
    before { index }
    subject(:index) { get :index, :format => format }
    context 'when format is json' do
      let(:format) { :json }
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
        let(:json) { JSON.parse(response.body, :symbolize_names => true) }
        it 'is an array' do
          expect(json).to be_kind_of(Array)
        end
        describe 'first element' do
          subject(:first_element) { json.first }

          it { is_expected.to be_kind_of(Hash) }
          it { is_expected.to have_key(:driver_id) }
          it { is_expected.to have_key(:backhauls) }
          it { is_expected.to have_key(:freight_revenue) }
          it { is_expected.to have_key(:customer_id) }
          it { is_expected.to have_key(:delivery_date) }
          it { is_expected.to have_key(:driver_rate) }
          it { is_expected.to have_key(:freight_bill_number) }
          it { is_expected.to have_key(:fuel_revenue) }
          it { is_expected.to have_key(:fuel_surcharge) }
          it { is_expected.to have_key(:layover) }
          it { is_expected.to have_key(:movement_type) }
          it { is_expected.to have_key(:other_hour_dollars) }
          it { is_expected.to have_key(:order_number_text) }
          it { is_expected.to have_key(:origin_name) }
          it { is_expected.to have_key(:paid_date) }
          it { is_expected.to have_key(:revenue) }
          it { is_expected.to have_key(:split_rate) }
          it { is_expected.to have_key(:total_freight_revenue) }
        end
      end
      describe 'response.body' do
        it 'is equal to driver_commissions_history json' do
          expect(response.body).to eq(driver_commission_history.to_json)
        end
      end
    end
    context 'when format is html' do
      let(:format) { :html }
      it 'responds with 406' do
        expect(response.status).to eq(406)
      end
    end
  end
  describe 'GET by_paid_date' do
    let(:paid_date) { Date.new(2012, 01, 01) }
    before { by_paid_date }
    subject(:by_paid_date) do
      get :by_paid_date,
          :format => format,
          :paid_date => paid_date
    end
    context 'when format is json' do
      let(:format) { :json }
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
        let(:json) { JSON.parse(response.body, :symbolize_names => true) }
        it 'is an array' do
          expect(json).to be_kind_of(Array)
        end
        describe 'first element' do
          subject(:first_element) { json.first }

          it { is_expected.to be_kind_of(Hash) }
          it { is_expected.to have_key(:driver_id) }
          it { is_expected.to have_key(:backhauls) }
          it { is_expected.to have_key(:freight_revenue) }
          it { is_expected.to have_key(:customer_id) }
          it { is_expected.to have_key(:delivery_date) }
          it { is_expected.to have_key(:driver_rate) }
          it { is_expected.to have_key(:freight_bill_number) }
          it { is_expected.to have_key(:fuel_revenue) }
          it { is_expected.to have_key(:fuel_surcharge) }
          it { is_expected.to have_key(:layover) }
          it { is_expected.to have_key(:movement_type) }
          it { is_expected.to have_key(:other_hour_dollars) }
          it { is_expected.to have_key(:order_number_text) }
          it { is_expected.to have_key(:origin_name) }
          it { is_expected.to have_key(:paid_date) }
          it { is_expected.to have_key(:revenue) }
          it { is_expected.to have_key(:split_rate) }
          it { is_expected.to have_key(:total_freight_revenue) }
        end
      end
    end
  end
end
