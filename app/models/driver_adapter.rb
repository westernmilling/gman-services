require 'lib/hash_extensions'

# DriverAdapter
class DriverAdapter
  # self.using(:grossman).connection.current_shard

  class << self
    def connection
      ActiveRecord::Base.using(:grossman).connection
    end

    def connected_with_octopus?
      ActiveRecord::Base.using(:grossman).connected_with_octopus?
    end

    def all
      results = ActiveRecord::Base.connection.execute(query_sql)
      # results = results.each { |e| e.to_snake_keys }
      # ap results
      # ap replace_key(results)
      replace_key(results)
    end

    def replace_key(hashlist)
      mappings = {
          'DriverId' => 'driver_id',
          'FirstName' => 'first_name',
          'LastName' => 'last_name'
      }
      hashlist.map do |e|
        Hash[e.map { |k, v| [mappings[k] || k, v] }]
      end
    end

    def query_sql
      ActiveRecord::Base.send(:sanitize_sql_array, ['
    SELECT
      DriverId
      , FirstName
      , LastName
    FROM
      Trucking_Drivers
    WHERE
      DriverType = ?', 'DR'])
    end
  end
end
