class Order
  class Reference < ActiveRecord::Base
    establish_connection "grossman_#{Rails.env}".to_sym

    self.primary_key = 'FeedXrefKey'
    self.table_name = 'InvCustomerOrders_CrossReference'

    belongs_to :order, foreign_key: :FeedXrefKey, primary_key: :OrderKey

    # Include the order details to avoid issues with accessing the association
    # after it has been load (which executes a statement with LIMIT that is
    # not supported by Relativities SQL dialect)
    def self.default_scope
      select(column_names.map(&:to_s))
        .includes(:order)
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
end
