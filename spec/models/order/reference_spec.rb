require 'rails_helper'

RSpec.describe Order::Reference, type: :model do
  it do
    is_expected
      .to belong_to(:order)
      .with_foreign_key(:FeedXrefKey)
      .with_primary_key(:OrderKey)
  end

  describe '.column_names' do
    subject { described_class.column_names }

    it do
      is_expected.to eq(
        %w{
          FeedXrefKey
          OrderNumber
          OrderStatusCd
          ShipDate
          WarehouseId
          UuidHeader
        }
      )
    end
  end

  describe '.ransackable_scopes' do
    subject { described_class.ransackable_scopes }

    it do
      is_expected.to eq([:warehouse_id_eq, :order_number_eq])
    end
  end
end
