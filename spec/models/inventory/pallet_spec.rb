require 'rails_helper'

RSpec.describe Inventory::Pallet, type: :model do
  describe '.column_names' do
    subject { described_class.column_names }

    it do
      is_expected.to eq(
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
      )
    end
  end
end
