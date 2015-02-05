# DriverAdapter
class DriverAdapter < ActiveRecord::Base
  # self.using(:grossman).connection.current_shard

  QUERY = <<SQL
    SELECT DriverId, FirstName, LastName
    FROM Trucking_Drivers
    WHERE DriverType = ?
SQL

  class << self
    def connection
      Octopus.using(:grossman) do
        ActiveRecord::Base.connection
      end
    end

    def connected_with_octopus?
      Octopus.using(:grossman) do
        ActiveRecord::Base.connected_with_octopus?
      end
    end

    def all
      Octopus.using(:grossman) do
        results = connection.execute(sanitized_sql)
        results.map(&:to_snake_keys)
      end
    end

    def sanitized_sql
      ActiveRecord::Base.send(:sanitize_sql_array, [QUERY, 'DR'])
    end

    def not_supported
      fail 'Not supported!'
    end
    alias :new :not_supported
    alias :delete :not_supported
    alias :destroy :not_supported
  end
end
