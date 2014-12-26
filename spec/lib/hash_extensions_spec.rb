require 'rails_helper'
require 'lib/hash_extensions'

RSpec.describe 'to_snake_keys' do
  describe 'to_snake_key' do
    let(:convert) { input.map(&:to_snake_keys).first }
    context 'drivers' do
      let(:input) do
        [
          {
            'DriverId' => Faker::Number.number(4),
            'FirstName' => Faker::Name.first_name,
            'LastName' => Faker::Name.last_name
          }
        ]
      end
      # let(:convert) { input.map(&:to_snake_keys).first }
      it { expect(convert).to have_key(:driver_id) }
      it { expect(convert).to have_key(:first_name) }
      it { expect(convert).to have_key(:last_name) }
    end

    describe 'underscore_key' do
      let(:input) { [{ 'AaBb' => 'value' }] }

      it 'contains an underscore key' do
        expect(convert).to have_key(:aa_bb)
      end
    end
  end
end
