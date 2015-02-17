# DriverCommissionHistoryAdapter
class DriverCommissionHistoryAdapter < GrossmanAdapter
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
        , DrvrcomhKey
        FROM
          Trucking_Drivers_Commissions_History
SQL

  QUERY_BY_PAID_DATE = QUERY_ALL + 'WHERE PaidDate = ?'

  class << self
    def all
      results = gman_connection.execute(sanitized_sql(QUERY_ALL))
      results.map(&:to_snake_keys)
    end

    def by_paid_date(paid_date)
      results = gman_connection
                .execute(sanitized_sql(QUERY_BY_PAID_DATE, paid_date))
      results.map(&:to_snake_keys)
    end

    def sanitized_sql(query, *options)
      ActiveRecord::Base.send(:sanitize_sql_array, [query, options])
    end
  end
end
