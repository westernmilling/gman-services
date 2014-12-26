require 'rails_helper'
require 'lib/hash_extensions'

RSpec.describe 'to_snake_keys' do
  describe 'to_snake_key' do
    let(:results) do
      [
        {
          'DriverId' => Faker::Number.number(4),
          'FirstName' => Faker::Name.first_name,
          'LastName' => Faker::Name.last_name
        }
      ]
    end
    let(:convert) { results.map(&:to_snake_keys).first }
    it { expect(convert).to have_key(:driver_id) }
    it { expect(convert).to have_key(:first_name) }
    it { expect(convert).to have_key(:last_name) }
  end
end
