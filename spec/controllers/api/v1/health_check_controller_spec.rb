require 'rails_helper'

RSpec.describe Api::V1::HealthCheckController, type: :controller do
  before do
    allow(controller).to receive(:doorkeeper_token).and_return(token)
  end
  let(:token) { double acceptable?: true }

  describe 'doorkeeper token' do
    context 'token accepted' do
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

  describe 'GET :index' do
    context 'Customer.count returns successfully' do
      before do
        allow(Customer)
          .to receive(:count)
          .and_return(12)

        get :index
      end

      it 'responds with 200' do
        expect(response.status).to eq(200)
      end

      it 'responds with json' do
        expect(response.content_type).to eq('application/json')
      end

      it 'body is not a null string' do
        parsed_json = JSON.parse(response.body)
        expect(parsed_json['health_check']).to eq('Passed')
      end
    end

    context 'Customer.count returns 0' do
      before do
        allow(Customer)
          .to receive(:count)
          .and_return(nil)

        get :index
      end

      it 'responds with 500' do
        expect(response.status).to eq(500)
      end

      it 'responds with json' do
        expect(response.content_type).to eq('application/json')
      end

      it 'body is not a null string' do
        parsed_json = JSON.parse(response.body)
        expect(parsed_json['health_check']).to eq('Failed')
      end
    end

    context 'a ActiveRecord::JDBCError is raised' do
      before do
        allow(Customer)
          .to receive(:count)
          .and_raise(ActiveRecord::JDBCError)

        get :index
      end

      it 'fails the health check' do
        expect(JSON.parse(response.body)['health_check']).to eq('Failed')
      end
    end
  end
end
