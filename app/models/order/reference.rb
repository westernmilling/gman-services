class Order
  class Reference < ActiveRecord::Base
    establish_connection "grossman_#{Rails.env}".to_sym

    self.primary_key = 'FeedXrefKey'
    self.table_name = 'InvCustomerOrders_CrossReference'

    belongs_to :order, foreign_key: :FeedXrefKey, primary_key: :OrderKey

    scope :ship_date_eq,
          ->(ship_date) { where("ShipDate = '#{ship_date}'") }

    # Fetch the order "manually" to avoid issues accessing associations.
    def order
      @order ||= Order.where(OrderKey: self.FeedXrefKey).to_a.first
    end

    def self.default_scope
      select(column_names.map(&:to_s))
    end

    def self.column_names
      %w{
        FeedXrefKey
        OrderNumber
        ShipDate
        WarehouseId
        UuidHeader
      }
    end
  end

  def self.ransackable_scopes(_auth_object = nil)
    [:ship_date_eq]
  end
end
