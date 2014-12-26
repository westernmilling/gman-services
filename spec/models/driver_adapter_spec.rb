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
  describe '#all' do
    before do
      create(:trucking_drivers)
    end
    let(:all_drivers) { ActiveRecord::Base.connection.execute(driver_query) }
    let(:convert) { all_drivers.map(&:to_snake_keys) }
    let(:driver) { convert.first }

    it 'empty is not false' do
      expect(all_drivers.empty?).to be_falsey
    end

    it { expect(driver).to have_key(:driver_id) }
    it { expect(driver).to have_key(:first_name) }
    it { expect(driver).to have_key(:last_name) }
  end
end
