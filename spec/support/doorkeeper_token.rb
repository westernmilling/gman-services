def doorkeeper_token
  application = Doorkeeper::Application.create!(
      :name => 'Test',
      :redirect_uri => 'urn:ietf:wg:oauth:2.0:oob')

  client = OAuth2::Client.new(application.uid, application.secret,
                              :site => 'http://localhost:3000') do |b|
    b.request :url_encoded
    b.adapter :rack, Rails.application
  end

  client.client_credentials.get_token
end
