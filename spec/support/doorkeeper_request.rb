def doorkeeper_request
  application = create(:doorkeeper_application)
  client = OAuth2::Client.new(application.uid, application.secret,
                              :site => 'http://localhost:3000') do |b|
    b.request :url_encoded
    b.adapter :rack, Rails.application
  end

  client.client_credentials.get_token
end
