require 'rails_helper'

RSpec.describe InventoryItemAdapter, :type => :model do
  let(:inventory_item_adapter) { InventoryItemAdapter }

  describe '#new' do
    subject { inventory_item_adapter.new }

    it { expect { subject }.to raise_error.with_message(/Not supported!/) }
  end

  describe '#delete' do
    subject { inventory_item_adapter.delete }

    it { expect { subject }.to raise_error.with_message(/Not supported!/) }
  end
  describe '#destroy' do
    subject { inventory_item_adapter.delete }

    it { expect { subject }.to raise_error.with_message(/Not supported!/) }
  end

  describe '#connected_with_octopus?' do
    subject { inventory_item_adapter.connected_with_octopus? }

    it { is_expected.to be_truthy }
  end

  describe '#connection' do
    subject do
      Octopus.using(:grossman) do
        inventory_item_adapter.connection.current_shard
      end
    end

    it 'current_shard is equal to grossman' do
      expect(is_expected.to eq(:grossman))
    end
  end

  describe '#all' do
    before do
      Octopus.using(:grossman) do
        create(:inventory_item)
      end
    end

    subject(:inventory_items) { inventory_item_adapter.all }

    it 'empty is not false' do
      expect(inventory_items.empty?).to be_falsey
    end
    describe 'first item' do
      subject { inventory_items.first }

      it { is_expected.to have_key(:item_id) }
      it { is_expected.to have_key(:in_item_description) }
    end
  end
  describe '#like_id_description' do
    before do
      Octopus.using(:grossman) do
        create(:inventory_item, :item_id => 1, :in_item_description => 'desc')
      end
    end

    subject(:inventory_items) do
      inventory_item_adapter.like_id_description(1, 'desc')
    end
    it 'empty is not false' do
      expect(inventory_items.empty?).to be_falsey
    end
    describe 'first item' do
      subject { inventory_items.first }

      it { is_expected.to have_key(:item_id) }
      it { is_expected.to have_key(:in_item_description) }
    end
  end
end
