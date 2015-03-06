require 'yaml'

load_params = YAML::load_file('config/application.yml')
server_params = load_params['production'].symbolize_keys

set :password, ask('Server password', '')
server server_params[:deployment_url],
       :user => server_params[:deployment_user],
       :port => 22,
       :password => fetch(:password),
       :roles => %w{web app db}
