require 'yaml'

load_params = YAML::load_file('config/application.yml')
server_params = load_params[Rails.env.to_s].symbolize_keys

server server_params[:deployment_url],
       :user => server_params[:deployment_user],
       :port => 22,
       :password => server_params[:development_pass],
       :roles => %w{web app db}
