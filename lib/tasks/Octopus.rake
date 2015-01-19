task :reconnect_octopus do
  if ActiveRecord::Base.connection.is_a?(Octopus::Proxy)
    ActiveRecord::Base.connection.initialize_shards(Octopus.config)
  end
end
# task :'db:migrate' => :reconnect_octopus
task :'db:schema:dump' => :reconnect_octopus

# desc "Migrate the database (options: VERSION=x, VERBOSE=false)."
# task :migrate => :environment do
#   ActiveRecord::Migration.verbose =
#     ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
#   ActiveRecord::Migrator.migrate("db/migrate/",
#     ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
#   Rake::Task["db:schema:dump"].invoke
#     if ActiveRecord::Base.schema_format == :ruby
# end
# desc 'Load a custom.rb file into the database'
# task :load_default_schema do
#   file = ENV['SCHEMA'] || "path_to_your_file"
#   if File.exists?(file)
#     load(file)
#   else
#     abort %{#{file} doesn't exist yet.}
#   end
# end

# task :shard_dump do
#   # for each migration, make migrations/<nameofmigration>_schema.rb
#   # and make shards/<shardname>_schema.rb
# # do db:migrate on each version of the migration.
# #rake db:migrate:up VERSION=20090408054532
# end
