class Order
  class Reference < ActiveRecord::Base
    establish_connection "grossman_#{Rails.env}".to_sym

    self.primary_key = 'FeedXrefKey'
    self.table_name = 'InvCustomerOrders_CrossReference'

    belongs_to :order, foreign_key: :FeedXrefKey, primary_key: :OrderKey

    scope :ship_date_eq,
          ->(ship_date) { where("ShipDate = '#{ship_date}'") }

    scope :ship_date_and_warehouse_id_eq,
          (
            lambda(ship_date, warehouse_id) do
              where("ShipDate = '#{ship_date}' "\
                    "AND WarehouseId = #{warehouse_id}")
            end
          )

    def self.where(_anything)
      fail 'Please dont'
    end

    def self.default_scope
      select(column_names.map(&:to_s))
        .includes(order: :lines)
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
    [:ship_date_and_warehouse_id_eq]
  end
end
