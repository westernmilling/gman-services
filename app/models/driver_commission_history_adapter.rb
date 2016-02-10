class DriverCommissionHistoryAdapter
  class << self
    def all
      DriverCommissionHistory
        .all
        .map(&:attributes)
        .map(&:to_snake_keys)
    end

    def by_paid_date(paid_date)
      DriverCommissionHistory
        .where(PaidDate: paid_date)
        .map(&:attributes)
        .map(&:to_snake_keys)
    end
  end
end
