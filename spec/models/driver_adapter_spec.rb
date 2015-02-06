require 'rails_helper'

RSpec.describe DriverAdapter, :type => :model do
  let(:driver_adapter) { DriverAdapter }

  describe '#all' do
    before do
      Octopus.using(:grossman) do
        create(:driver)
      end
    end

    subject(:drivers) { driver_adapter.all }

    it 'empty is not false' do
      expect(drivers.empty?).to be_falsey
    end
    describe 'first driver' do
      subject { drivers.first }
      its(:keys) do
        is_expected.to eq([:driver_id,
                           :first_name,
                           :last_name])
      end
    end
  end
end
