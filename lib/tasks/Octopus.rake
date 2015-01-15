task :reconnect_octopus do
  if ActiveRecord::Base.connection.is_a?(Octopus::Proxy)
    ActiveRecord::Base.connection.initialize_shards(Octopus.config)
  end
end
task :'db:migrate' => :reconnect_octopus
