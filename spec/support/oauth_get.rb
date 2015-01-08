def oauth_get(url, client_id = nil, client_secret = nil)
  client = OAuth2::Client.new(client_id, client_secret,
                              :raise_errors => false,
                              :site => 'http://localhost:3000') do |b|
    b.request :url_encoded
    b.adapter :rack, Rails.application
  end

  client.client_credentials.get_token.get(url)
end
