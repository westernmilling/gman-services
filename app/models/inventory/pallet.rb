module Inventory
  class Pallet < ActiveRecord::Base
    establish_connection "grossman_#{Rails.env}".to_sym

    # NB: Details not included due to join issues.
    #     Consider using composite keys (if they work)
    #     https://github.com/composite-primary-keys/composite_primary_keys
    # has_many :inventory_pallet_details,
    #          foreign_key: :PalletId,
    #          class_name: Inventory::Pallet::Detail

    scope :pallet_number_eq, (
          lambda do |pallet_number|
            where("InvPallet_MainInfo.InPallet_PalletNo = #{pallet_number}")
          end)
    scope :warehouse_id_eq, (
          lambda do |warehouse_id|
            where("InvPallet_MainInfo.WarehouseId = #{warehouse_id}")
          end)

    self.primary_key = 'PalletId'
    self.table_name = 'InvPallet_MainInfo'

    def self.column_names
      %w{
        PalletId
        WarehouseId
        ItemId
        InPallet_PalletNo
        InPallet_OrderNo
        InPallet_TranDate
        InPallet_TranTime
        InPallet_TranTypeCd
        InPallet_StatusCd
        InPallet_TagTypeCd
        InPallet_Location
        InPallet_Area
        InPallet_SequenceNo
        InPallet_StorageDateCymd
      }
    end

    def self.ransackable_scopes(_auth_object = nil)
      [:pallet_number_eq, :warehouse_id_eq]
    end
  end
end
