class Order
  class Reference < ActiveRecord::Base
    establish_connection "grossman_#{Rails.env}".to_sym

    self.primary_key = 'FeedXrefKey'
    self.table_name = 'InvCustomerOrders_CrossReference'

    belongs_to :order, foreign_key: :FeedXrefKey, primary_key: :OrderKey

    scope :warehouse_id_eq,
          lambda { |warehouse_id|
            where("#{table_name}.WarehouseId = #{warehouse_id}")
          }
    scope :order_number_eq,
          lambda { |order_number|
            where("#{table_name}.OrderNumber = #{order_number}")
          }

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

    def self.ransackable_scopes(_auth_object = nil)
      [:warehouse_id_eq, :order_number_eq]
    end
  end
end
