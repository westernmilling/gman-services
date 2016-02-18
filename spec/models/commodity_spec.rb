require 'rails_helper'

RSpec.describe Commodity, type: :model do
  it do
    is_expected
      .to belong_to(:unit_of_measure)
      .class_name('Commodity::UnitOfMeasure')
      .with_foreign_key(:COMM_CommUOMId)
  end

  describe '.column_names' do
    subject { described_class.column_names }

    it do
      is_expected.to eq(
        %w{
          CommodityId
          COMM_Description
          COMM_CommUOMId
          COMM_ConversionFactor
        }
      )
    end
  end
end
