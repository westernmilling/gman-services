require 'rails_helper'

RSpec.describe DriverAdapter, :type => :model do
  let(:driver_adapter) { DriverAdapter }

  describe '#connected_with_octopus?' do
    subject { driver_adapter.connected_with_octopus? }

    it { is_expected.to be_truthy }
  end

  describe '#connection' do
    subject { driver_adapter.connection.current_shard }

    it 'current_shard is equal to grossman' do
      expect(is_expected.to eq(:grossman))
    end
  end
  describe '#all' do
    before do
      create(:driver)
    end

    subject(:drivers) { driver_adapter.all }

    it 'empty is not false' do
      expect(drivers.empty?).to be_falsey
    end
    describe 'first driver' do
      subject { drivers.first }

      it { is_expected.to have_key(:driver_id) }
      it { is_expected.to have_key(:first_name) }
      it { is_expected.to have_key(:last_name) }
    end
  end
end
