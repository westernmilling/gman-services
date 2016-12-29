require 'rails_helper'

RSpec.describe PickUpOrder, type: :model do
  let(:instance) { PickUpOrder.new }

  subject { instance }

  it do
    is_expected
      .to belong_to(:contract)
      .with_foreign_key([:ContractId, :ContractLocationId])
      .with_primary_key([:Inv_ContractId, :LocationId])
  end
  it do
    is_expected
      .to belong_to(:item)
      .class_name('InventoryItem')
      .with_foreign_key(:ItemId)
      .with_primary_key(:ItemId)
  end

  describe '#pickup_type' do
    let(:instance) do
      PickUpOrder.new(PickupType: 4)
    end

    subject { instance.pickup_type }

    it 'lookup the pickup type' do
      expect(subject).to eq 'Inventory Order'
    end
  end

  describe '#release_number' do
    let(:instance) do
      PickUpOrder.new(ReleasePrefix: '10000', ReleaseLoadNumber: '0001')
    end

    subject { instance.release_number }

    it 'should combine the prefix and load number' do
      expect(subject).to eq(
        format('%-10s%04d', instance.ReleasePrefix, instance.ReleaseLoadNumber)
      )
    end
  end

  describe '#status' do
    subject { instance.status }

    context 'when the Status is 0' do
      let(:instance) { PickUpOrder.new(Status: 0) }

      it 'should return Open' do
        expect(subject).to eq 'Open'
      end
    end

    context 'when the Status is 1' do
      let(:instance) { PickUpOrder.new(Status: 1) }

      it 'should return Used' do
        expect(subject).to eq 'Used'
      end
    end
  end

  describe '.column_names' do
    subject { described_class.column_names }

    it do
      is_expected.to eq(
        %w{
          ContractId
          ContractLocationId
          CarrierCustomerNumber
          CarrierCustomerSub
          FreightAmount
          ItemId
          LoadNumber
          Origin
          OriginState
          OriginWeightCertificate
          OriginGrossWeight
          OriginTareWeight
          OriginNetWeight
          PickupType
          PurchaseCustomerId
          ReleasePrefix
          ReleaseLoadNumber
          ShipDate
          Shipper
          SplitFg
          SplitTicketNumber
          Status
          TicketLocationId
        }
      )
    end
  end
end
