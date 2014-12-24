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
      sql = ActiveRecord::Base.send(:sanitize_sql_array, ['
    SELECT
      DriverId
      , FirstName
      , LastName
    FROM
      Trucking_Drivers
    WHERE
      DriverType = ?', 'DR'])

      ActiveRecord::Base.connection.execute(sql)
    end
  end
end
