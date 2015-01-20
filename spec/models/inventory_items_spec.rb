require 'rails_helper'

RSpec.describe InventoryItem, :type => :model do
  describe '#init' do
    let(:inventory_item) do
      Octopus.using(:grossman) do
        InventoryItem.new
      end
    end
    subject { inventory_item.attributes.to_snake_keys }

    it { is_expected.to be_truthy }
    it { is_expected.to have_key(:item_id) }
    it { is_expected.to have_key(:in_item_description) }
    it { is_expected.to have_key(:uuid) }
  end
end
