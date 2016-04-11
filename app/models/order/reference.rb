class Order
  class Reference < ActiveRecord::Base
    establish_connection "grossman_#{Rails.env}".to_sym

    self.primary_key = 'FeedXrefKey'
    self.table_name = 'InvCustomerOrders_CrossReference'

    belongs_to :order, foreign_key: :FeedXrefKey, primary_key: :OrderKey
    belongs_to :additional,
               class_name: Order::Additional,
               foreign_key: :FeedXrefKey, primary_key: :OrderKey

    def self.default_scope
      select(column_names.map(&:to_s))
        .includes(:order, :additional)
        .joins(:order, :additional)
    end

    # FeedXrefKey is the OrderKey
    # OrderNumber
    def self.column_names
      %w{
        FeedXrefKey
        ShipDate
      }
    end
  end
end
