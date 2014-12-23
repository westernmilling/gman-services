require 'rails_helper'

RSpec.describe DriverAdapter, :type => :model do
  let(:driver_adapter) { DriverAdapter }

  describe '#connected_with_octopus?' do
    subject { driver_adapter.connected_with_octopus? }

    it { is_expected.to be_truthy }
  end

  describe '#connection' do
    subject { driver_adapter.connection }

    it 'current_shard is equal to grossman' do
      expect(subject.current_shard).to eq(:grossman)
    end
  end
end
