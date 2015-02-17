# DriverAdapter
class DriverAdapter < GrossmanAdapter
  QUERY = <<SQL
    SELECT
      DriverId,
      ActiveFG,
      DriverType,
      SubHaulerFg,
      FirstName,
      LastName
    FROM Trucking_Drivers
    WHERE DriverType = ?
SQL

  class << self
    def all
      results = gman_connection.execute(sanitized_sql)
      results.map(&:to_snake_keys)
    end

    def sanitized_sql
      ActiveRecord::Base.send(:sanitize_sql_array, [QUERY, 'DR'])
    end
  end
end
