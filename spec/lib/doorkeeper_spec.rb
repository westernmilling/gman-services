require 'rails_helper'

RSpec.describe 'test doorkeeper' do # , :type => :api do
  let(:application) do
    Doorkeeper::Application.create!(
        :name => 'Test',
        :redirect_uri => redirect_uri)
  end
  let(:redirect_uri) { 'urn:ietf:wg:oauth:2.0:oob' }

  context 'valid application id and secret' do
    # Break this up to test:
    #  - get_token
    #  - 200 responses
    #  - some data

    describe 'doorkeeper' do
      it 'works' do
        client = OAuth2::Client.new(application.uid, application.secret,
                                    :site => 'http://localhost:3000') do |b|
          b.request :url_encoded
          b.adapter :rack, Rails.application
        end

        token = client.client_credentials.get_token

        expect(token).to be_present

        response = token.get('/api/v1/drivers.json')

        expect(response).to be_present
        expect(response.status).to eq(200)
      end
    end
  end

  context 'invalid application id and secret' do
    it 'works' do
      client = OAuth2::Client.new('invalid', 'invalid',
                                  :site => 'http://localhost:3000') do |b|
        b.request :url_encoded
        b.adapter :rack, Rails.application
      end

      expect { client.client_credentials.get_token }.to raise_error(OAuth2::Error)
    end
  end
end
