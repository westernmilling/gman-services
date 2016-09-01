class Order
  class Reference < ActiveRecord::Base
    establish_connection "grossman_#{Rails.env}".to_sym

    self.primary_key = 'FeedXrefKey'
    self.table_name = 'InvCustomerOrders_CrossReference'

    belongs_to :order, foreign_key: :FeedXrefKey, primary_key: :OrderKey

    # Fetch the order "manually" to avoid issues accessing associations.
    def order
      @order ||= Order.where(OrderKey: self.FeedXrefKey).to_a.first
    end

    def status
      STATUS_MAP[self.OrderStatusCd]
    end

    def self.default_scope
      select(column_names.map(&:to_s))
    end

    def self.column_names
      %w{
        FeedXrefKey
        OrderNumber
        OrderStatusCd
        ShipDate
        WarehouseId
        UuidHeader
      }
    end
  end
end
