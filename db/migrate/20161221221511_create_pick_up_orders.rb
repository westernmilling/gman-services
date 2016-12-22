class CreatePickUpOrders < ActiveRecord::Migration
  def change
    return if PickUpOrder
              .connection
              .class
              .to_s
              .include?('Relativity')

    @connection = PickUpOrder.connection

    create_table :InvPickUpOrders, id: false do |t|
      t.string :ContractId
      t.integer :ContractLocationId
      t.integer :LoadNumber
      t.integer :CarrierCustomerNumber
      t.integer :CarrierCustomerSub
      t.decimal :FreightAmount, precision: 9, scale: 5
      t.string :ItemId
      t.string :ReleasePrefix
      t.string :Origin
      t.string :OriginState
      t.integer :OriginWeightCertificate
      t.integer :OriginGrossWeight
      t.integer :OriginTareWeight
      t.integer :OriginNetWeight
      t.integer :PickupType
      t.string :PurchaseCustomerId
      t.date :ShipDate
      t.string :Shipper
      t.string :SplitFg # Y or N
      t.integer :SplitTicketNumber
      t.integer :Status
      t.integer :TicketLocationId
    end
  end
end
