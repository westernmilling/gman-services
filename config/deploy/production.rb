require 'yaml'

load_params = YAML::load_file('config/application.yml')
server_params = load_params['production'].symbolize_keys
puts server_params.to_json
# set :password, ask('Server password', '')
server server_params[:deployment_url],
       :user => server_params[:deployment_user],
       :port => 22,
       :roles => %w{web app db}
