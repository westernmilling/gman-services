require 'rails_helper'

RSpec.describe Commodity::UnitOfMeasure, type: :model do
  describe '.column_names' do
    subject { described_class.column_names }

    it do
      is_expected.to eq(
        %w{
          CommUOMId
          CommUOMDescription
        }
      )
    end
  end
end
