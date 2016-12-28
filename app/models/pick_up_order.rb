require_relative 'concerns/pick_up_order'

class PickUpOrder < ActiveRecord::Base
  establish_connection "grossman_#{Rails.env}".to_sym

  PICKUP_TYPE = %w(
    Contract
    Cash
    Internal\ Transfer
    Elevator\ Sales
    Inventory\ Order
    Delivery\ Sheets
  ).freeze

  STATUS = %w(Open Used).freeze

  # Arguably the primary_key is PickUpKey, however that didn't play nice with
  # joins/includes from the contract to the pick_up_orders.
  # It would appear that PickUpKey is actually a product of the ContractId
  # and LoadNumber + "00" anyway, so I think we're safe doing this.
  self.primary_key = [:ContractId, :LoadNumber]
  self.table_name = :InvPickUpOrders

  include PickUpOrder::Columns
  include PickUpOrder::Ransack

  # NB: has_one worked, where belongs_to did not.
  has_one :contract,
          foreign_key: [:Inv_ContractId, :LocationId],
          primary_key: [:ContractId, :ContractLocationId]

  include PickUpOrder::Scopes

  def pickup_type
    PICKUP_TYPE[self.PickupType]
  end

  def release_number
    format('%-10s%04d', self.ReleasePrefix, self.ReleaseLoadNumber)
  end

  def status
    STATUS[self.Status]
  end

  def self.default_scope
    includes(:contract)
      .joins(:contract)
  end
end
