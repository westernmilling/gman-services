class Order < ActiveRecord::Base
  establish_connection "grossman_#{Rails.env}".to_sym

  self.primary_key = 'OrderKey'
  self.table_name = 'InvCustomerOrders_Open_MainInfo'

  has_many :lines,
           foreign_key: :InOrd_WareShipToOrderKey,
           primary_key: :InOrd_WareShipToOrderKey

  def self.default_scope
    select(column_names.map(&:to_s))
      .includes(:lines)
  end

  def self.column_names
    %w{
      OrderKey
      InOrd_OrderNo
      InOrd_WareShipToOrderKey
      WarehouseId
    }
  end
end
