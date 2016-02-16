require 'rails_helper'

RSpec.describe InventoryItemAdapter, type: :model do
  let(:inventory_item_adapter) { InventoryItemAdapter }

  describe '#all' do
    before do
      create(:inventory_item)
    end

    subject(:inventory_items) { inventory_item_adapter.all }

    it 'empty is not false' do
      expect(inventory_items.empty?).to be_falsey
    end
    describe 'first item' do
      subject { inventory_items.first }

      its(:keys) do
        is_expected.to eq([:item_id,
                           :in_item_description])
      end
    end
    describe '#like_id_description' do
      before do
        create(:inventory_item, ItemId: 1, InItem_Description: 'desc')
      end

      subject(:inventory_items) do
        inventory_item_adapter.like_id_description(1, 'desc')
      end
      it 'empty is not false' do
        expect(inventory_items.empty?).to be_falsey
      end
      describe 'first item' do
        subject { inventory_items.first }
        its(:keys) do
          is_expected.to eq([:item_id,
                             :in_item_description])
        end
      end
    end
  end
end
