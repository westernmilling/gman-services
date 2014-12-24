require 'rails_helper'
require 'awesome_print'

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
    let(:sql) do
      ActiveRecord::Base.send(:sanitize_sql_array, ['
    SELECT
      *
    FROM
      drivers_view
      '])
    end
    let(:all_drivers) { ActiveRecord::Base.connection.execute(sql) }
    let(:driver) { driver_adapter.all.first }

    it 'empty is not false' do
      # rake db:seed:test RAILS_ENV=test
      expect(all_drivers.empty?).to be_falsey
    end

    it { expect(driver).to have_key('DriverId') }
    it { expect(driver).to have_key('FirstName') }
    it { expect(driver).to have_key('LastName') }
  end
end
