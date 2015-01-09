require 'rails_helper'

RSpec.describe Api::V1::Trucking::DriversController, :type => :controller do
  before do
    allow(controller).to receive(:doorkeeper_token).and_return(token)
  end

  let(:drivers) do
    [
      {
        :driver_number => Faker::Number.number(4),
        :first_name => Faker::Name.first_name,
        :last_name => Faker::Name.last_name,
        :driver_type => 'DR'
      },
      {
        :driver_number => Faker::Number.number(4),
        :first_name => Faker::Name.first_name,
        :last_name => Faker::Name.last_name,
        :driver_type => 'DR'
      }
    ]
  end
  before { allow(DriverAdapter).to receive(:all) { drivers } }

  describe 'doorkeeper token' do
    context 'token accepted' do
      let(:token) { double :acceptable? => true }
      it 'responds with 200' do
        get :index, :format => :json
        expect(response.status).to eq(200)
      end
    end

    context 'token not accepted' do
      let(:token) do
        double :acceptable? => false,
               :accessible? => false
      end
      it 'responds with 401' do
        get :index, :format => :json
        expect(response.status).to eq(401)
      end
    end
  end

  describe 'GET index' do
    let(:token) { double :acceptable? => true }

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
          it { is_expected.to have_key(:first_name) }
          it { is_expected.to have_key(:last_name) }
          it { is_expected.to have_key(:driver_number) }
          it { is_expected.to have_key(:driver_type) }
        end
      end

      describe 'response.body' do
        it 'is equal to drivers json' do
          expect(response.body).to eq(drivers.to_json)
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
end
