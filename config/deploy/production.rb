set :password, ask('Server password', '')
server Figaro.env.deployment_url, :user => Figaro.env.deployment_user,
                                  :port => 22,
                                  :password => fetch(:password),
                                  :roles => %w{web app db}
