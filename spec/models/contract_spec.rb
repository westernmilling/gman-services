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
  it do
    is_expected
      .to have_many(:pick_up_orders)
      .with_foreign_key([:ContractId, :ContractLocationId])
      .with_primary_key([:Inv_ContractId, :LocationId])
  end

  describe '#balance' do
    let(:instance) do
      described_class.new(
        CONT_Quantity: 50_000,
        CONT_DeliveredBushels: 30_000
      )
    end
    subject do
      instance.balance
    end

    it 'should return the sum of the quantity and ' \
       'the misleadingly named delivered bushels' do
      expect(subject).to eq(20_000)
    end
  end

  describe '#contract_type' do
    let(:instance) do
      described_class.new(
        CONT_ContractType: native_contract_type,
      )
    end
    subject do
      instance.contract_type
    end

    context 'when CONT_ContractType is P' do
      let(:native_contract_type) { 'P' }

      it { is_expected.to eq 'Purchase' }
    end

    context 'when CONT_ContractType is S' do
      let(:native_contract_type) { 'S' }

      it { is_expected.to eq 'Sale' }
    end
  end

  describe '#fob_location' do
    let(:instance) do
      described_class.new(
        CONT_FobLocationDescription1: native_fob_location_description
      )
    end
    subject do
      instance.fob_location
    end

    context 'when CONT_FobLocationDescription1 is D' do
      let(:native_fob_location_description) { 'D' }

      it { is_expected.to eq 'Delivered' }
    end

    context 'when CONT_FobLocationDescription1 is F' do
      let(:native_fob_location_description) { 'F' }

      it { is_expected.to eq 'FOB' }
    end
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
          CONT_FobLocationDescription1
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
