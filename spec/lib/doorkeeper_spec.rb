require 'rails_helper'

# module ApiHelper
#   include Rack::Test::Methods

#   def app
#     Rails.application
#   end
# end

# RSpec.configure do |config|
#   config.include ApiHelper, :type => :api #apply to all spec for apis folder
# end

RSpec.describe 'test doorkeeper' do #, :type => :api do
  # before(:all) {
  #   @pid = Kernel.spawn('rails s')
  # }
  # before {
  #   allow(QueryAdapter).to receive(:using).with('relativity') { QueryAdapter }
  #   allow(QueryAdapter).to receive(:get_drivers) { } #.and_return([])
  # }
  let(:application) {
    Doorkeeper::Application.create!(
        :name => 'Test',
        # :uid => Doorkeeper::OAuth::Helpers::UniqueToken.generate,
        # :secret => Doorkeeper::OAuth::Helpers::UniqueToken.generate,
        :redirect_uri => redirect_uri)
  }
  let(:redirect_uri) { 'urn:ietf:wg:oauth:2.0:oob' }

  # Add database cleaner to make sure the DB is clean after tests, since we don't want to use transations
  # Can we disable transactions per spec?

  context 'valid application id and secret' do
    # Break this up to test:
    #  - get_token
    #  - 200 responses
    #  - some data

    describe 'doorkeeper' do

      it 'works' do
        # application
        # puts Doorkeeper::Application.all.to_yaml

        # client = OAuth2::Client.new(application.uid, application.secret,
        #   :site => 'http://localhost:3000')

        client = OAuth2::Client.new(application.uid, application.secret,
                                    :site => 'http://localhost:3000') do |b|
          b.request :url_encoded
          b.adapter :rack, Rails.application
        end

        token = client.client_credentials.get_token

        expect(token).to be_present

        # Test getting some drivers
        response = token.get('/api/v1/trucking/drivers.json')

        # puts response.to_yaml

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

  # after(:all) {
  #   Process.kill('SIGKILL', @pid)
  # }

end
