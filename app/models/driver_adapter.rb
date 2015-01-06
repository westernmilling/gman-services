# DriverAdapter
class DriverAdapter
  # self.using(:grossman).connection.current_shard
  QUERY = <<SQL
    SELECT DriverId, FirstName, LastName
    FROM Trucking_Drivers
    WHERE DriverType = ?
SQL

  class << self
    def connection
      ActiveRecord::Base.using(:grossman).connection
    end

    def connected_with_octopus?
      ActiveRecord::Base.using(:grossman).connected_with_octopus?
    end

    def all
      results = connection.execute(sanitized_sql)
      results.map(&:to_snake_keys)
    end

    def sanitized_sql
      ActiveRecord::Base.send(:sanitize_sql_array, [QUERY, 'DR'])
    end
  end
end
