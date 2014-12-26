require 'lib/hash_extensions'
require 'awesome_print'
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
      results.map(&:to_snake_keys)
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
