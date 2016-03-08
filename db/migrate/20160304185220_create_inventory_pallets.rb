class CreateInventoryPallets < ActiveRecord::Migration
  return if Inventory::Pallet.connection.class.to_s.include?('Relativity')

  def change
    @connection = Inventory::Pallet.connection

    create_table :InvPallet_MainInfo do |t|
      t.string :PalletId, null: false
      t.integer :WarehouseId, null: false
      t.string :ItemId, null: false
      t.integer :InPallet_PalletNo, null: false
      t.integer :InPallet_OrderNo, null: false
      t.date :InPallet_TranDate, null: false
      t.datetime :InPallet_TranTime, null: false
      t.integer :InPallet_TranTypeCd, null: false
      t.integer :InPallet_StatusCd, null: false
      t.integer :InPallet_TagTypeCd, null: false
      t.integer :InPallet_Location, null: false
      t.integer :InPallet_Area, null: false
      t.integer :InPallet_SequenceNo, null: false
      t.date :InPallet_StorageDateCymd, null: false
    end
  end
end
