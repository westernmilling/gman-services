require 'rails_helper'
require 'lib/hash_extensions'

RSpec.describe 'Hash' do
  describe '.to_snake_key' do 
    subject(:convert) { input.map(&:to_snake_keys).first }
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
      it { is_expected.to have_key(:driver_id) }
      it { is_expected.to have_key(:first_name) }
      it { is_expected.to have_key(:last_name) }

    describe 'underscore_key' do
      subject(:input) { [{ 'AaBb' => 'value' }] }

      it 'contains an underscore key' do
        expect(convert).to have_key(:aa_bb)
      end
    end
  end
end
