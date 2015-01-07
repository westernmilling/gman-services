# DriverCommissionHistoryAdapter
class DriverCommissionHistoryAdapter
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
      ActiveRecord::Base.using(:grossman).connection
    end

    def connected_with_octopus?
      ActiveRecord::Base.using(:grossman).connected_with_octopus?
    end

    def all
      results = connection.execute(sanitized_sql(QUERY_ALL))
      results.map(&:to_snake_keys)
    end

    def by_paid_date(paid_date)
      results = connection.execute(sanitized_sql(QUERY_BY_PAID_DATE, paid_date))
      results.map(&:to_snake_keys)
    end

    def sanitized_sql(query, options = {})
      ActiveRecord::Base.send(:sanitize_sql_array, [query, options])
    end
  end
end