class Order < ActiveRecord::Base
  establish_connection "grossman_#{Rails.env}".to_sym

  self.primary_key = 'OrderKey'
  self.table_name = 'InvCustomerOrders_Open_MainInfo'

  STATUS_MAP = [
    :no_items,
    :ordered,
    :invoiced,
    :deleted
  ].freeze

  has_many :lines,
           foreign_key: :InOrd_WareShipToOrderKey,
           primary_key: :InOrd_WareShipToOrderKey

  def carrier_id
    format('%06d%02d',
           self.InOrd_CarrierCustomer,
           self.InOrd_CarrierCustomerSub)
  end

  def quantity_shipped
    lines
      .map(&:InOrd_QtyShipped)
      .inject(0, :+)
  end

  # Fetch the reference "manually" to avoid issues with recurring lookups.
  def reference
    @reference ||= Reference.where(FeedXrefKey: self.OrderKey).to_a.first
  end

  def status
    STATUS_MAP[self.InOrd_StatusCd]
  end

  def self.default_scope
    select(column_names.map(&:to_s))
      .includes(:lines)
  end

  def self.column_names
    %w{
      OrderKey
      InOrd_CarrierCustomer
      InOrd_CarrierCustomerSub
      InOrd_OrderNo
      InOrd_ShipDate
      InOrd_ShipTime
      InOrd_StatusCd
      InOrd_WareShipToOrderKey
      WarehouseId
    }
  end
end
