FactoryGirl.define do
  factory :inventory_pallet, class: 'Inventory::Pallet' do
    sequence(:PalletId) { |x| format('%06d   %04d', x, self.WarehouseId) }
    sequence(:WarehouseId) { |x| x }
    sequence(:ItemId) { |x| format('%04d', x) }
    sequence(:InPallet_PalletNo) { |x| format('%06d', x) }
    InPallet_OrderNo { self.InPallet_PalletNo }
    InPallet_TranDate { Date.current }
    InPallet_TranTime { DateTime.current }
    InPallet_TranTypeCd { [1, 2].sample }
    InPallet_StatusCd { [2, 4, 5].sample }
    InPallet_TagTypeCd { [1, 3].sample }
    InPallet_Location { (1..10).to_a.sample }
    InPallet_Area { (1..10).to_a.sample }
    InPallet_SequenceNo { (1..10).to_a.sample }
    InPallet_StorageDateCymd { Date.current }
  end
end
