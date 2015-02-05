# DriverCommissionHistoryAdapter
class DriverCommissionHistoryAdapter < ActiveRecord::Base
  # self.using(:grossman).connection.current_shard

  QUERY_ALL = <<SQL
        SELECT
          DriverId
        , Backhauls
        , FreightRevenue
        , CustomerId
        , DeliveryDate
        , DriverRate
        , FreightBillNumber
        , FuelSurcharge
        , Layover
        , MovementType
        , OtherHourDollars
        , OrderNumberText
        , OriginName
        , PaidDate
        , Revenue
        , SplitRate
        , TotalFreightRevenue
        FROM
          Trucking_Drivers_Commissions_History
SQL

  QUERY_BY_PAID_DATE = QUERY_ALL + 'WHERE PaidDate = ?'

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
        results = connection.execute(sanitized_sql(QUERY_ALL))
        results.map(&:to_snake_keys)
      end
    end

    def by_paid_date(paid_date)
      Octopus.using(:grossman) do
        results = connection.execute(sanitized_sql(QUERY_BY_PAID_DATE, paid_date))
        results.map(&:to_snake_keys)
      end
    end

    def sanitized_sql(query, options = {})
      Octopus.using(:grossman) do
        ActiveRecord::Base.send(:sanitize_sql_array, [query, options])
      end
    end

    def not_supported
      fail 'Not supported!'
    end
    alias :new :not_supported
    alias :delete :not_supported
    alias :destroy :not_supported
  end
end
