class PickUpOrder < ActiveRecord::Base
  establish_connection "grossman_#{Rails.env}".to_sym

  # Arguably the primary_key is PickUpKey, however that didn't play nice with
  # joins/includes from the contract to the pick_up_orders.
  # It would appear that PickUpKey is actually a product of the ContractId
  # and LoadNumber + "00" anyway, so I think we're safe doing this.
  self.primary_key = [:ContractId, :LoadNumber]
  self.table_name = :InvPickUpOrders

  # NB: has_one worked, where belongs_to did not.
  has_one :contract,
          foreign_key: [:Inv_ContractId, :LocationId],
          primary_key: [:ContractId, :ContractLocationId]

  def self.column_names
    %w{
      ContractId
      ContractLocationId
      CarrierCustomerNumber
      CarrierCustomerSub
      FreightAmount
      ItemId
      LoadNumber
      ReleasePrefix
      Origin
      OriginState
      OriginWeightCertificate
      OriginGrossWeight
      OriginTareWeight
      OriginNetWeight
      PickupType
      PurchaseCustomerId
      ShipDate
      Shipper
      SplitFg
      SplitTicketNumber
      Status
      TicketLocationId
    }
  end

  def self.default_scope
    includes(:contract)
      .joins(:contract)
  end
end
