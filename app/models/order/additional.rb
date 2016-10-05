class Order
  class Additional < ActiveRecord::Base
    establish_connection "grossman_#{Rails.env}".to_sym

    self.primary_key = 'OrderKey'
    self.table_name = 'InvCustomerOrders_Open_MainInfo_Additional3'

    def self.default_scope
      select(column_names.map(&:to_s))
    end

    def self.column_names
      %w{
        RewriteDate
        RewriteTime
        UUID
      }
    end
  end
end
