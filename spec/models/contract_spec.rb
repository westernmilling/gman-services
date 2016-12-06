require 'rails_helper'

RSpec.describe Contract, type: :model do
  it do
    is_expected
      .to belong_to(:commodity)
      .class_name('Commodity')
      .with_foreign_key(:CommodityId)
  end
  it do
    is_expected
      .to belong_to(:customer)
      .class_name('Customer')
      .with_foreign_key(:CustomerId)
  end
  it do
    is_expected
      .to belong_to(:unit_of_measure)
      .class_name('Commodity::UnitOfMeasure')
      .with_foreign_key(:CommUOMId)
  end

  describe '.column_names' do
    subject { described_class.column_names }

    it do
      is_expected.to eq(
        %w{
          CustomerId
          CommodityId
          ContractId
          CommUOMId
          LocationId
          CONT_ContractDate
          CONT_ContractNumber
          CONT_ContractSub
          CONT_ContractType
          CONT_DeliveredBushels
          CONT_FreightAdjustment
          CONT_Price
          CONT_Quantity
          CONT_FromDate
          CONT_ToDate
          Inv_ContractId
        }
      )
    end
  end
end
