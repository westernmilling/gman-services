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
    let(:all_drivers) { ActiveRecord::Base.connection.execute(driver_query) }
    let(:driver) { driver_adapter.all.first }

    it 'empty is not false' do
      # rake db:seed:test RAILS_ENV=test
      expect(all_drivers.empty?).to be_falsey
    end

    it { expect(driver).to have_key('driver_id') }
    it { expect(driver).to have_key('first_name') }
    it { expect(driver).to have_key('last_name') }
  end
  describe 'replace_key' do
    let(:result) do
      [
        {
          'DriverId' => Faker::Number.number(4),
          'FirstName' => Faker::Name.first_name,
          'LastName' => Faker::Name.last_name
        }
      ]
    end
    # let(:convert) { result.first.to_snake_keys }
    let(:convert) { driver_adapter.replace_key(result).first }
    it { expect(convert).to have_key('driver_id') }
    it { expect(convert).to have_key('first_name') }
    it { expect(convert).to have_key('last_name') }
  end
end
