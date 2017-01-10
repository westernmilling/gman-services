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

  describe '.item_id_eq' do
    before do
      subject_pool
    end

    let(:matching_item) { create(:inventory_item, ItemId: '1000') }
    let(:matching_pool) do
      create_list(:pick_up_order, 2, item: matching_item)
    end
    let(:subject_pool) do
      matching_pool + create_list(:pick_up_order, 2, ItemId: '2000')
    end

    subject { described_class.item_id_eq(item_id) }

    context 'when there are matching records' do
      let(:item_id) { '1000' }

      it 'should return matches' do
        expect(
          subject
            .map { |object| "#{object.ContractId}-#{object.LoadNumber}" }
        ).to contain_exactly(
          *matching_pool
            .map { |object| "#{object.ContractId}-#{object.LoadNumber}" }
        )
      end
    end

    context 'when there are no matching records' do
      let(:item_id) { '99' }

      it 'should return nothing' do
        expect(subject).to be_empty
      end
    end
  end

  describe '.status_eq' do
    before do
      subject_pool
    end

    let(:matching_pool) do
      create_list(:pick_up_order, 2, Status: 0)
    end
    let(:subject_pool) do
      matching_pool + create_list(:pick_up_order, 2, Status: 1)
    end

    subject { described_class.status_eq(status) }

    context 'when there are matching records' do
      let(:status) { 0 }

      it 'should return matches' do
        expect(
          subject
            .map { |object| "#{object.ContractId}-#{object.LoadNumber}" }
        ).to contain_exactly(
          *matching_pool
            .map { |object| "#{object.ContractId}-#{object.LoadNumber}" }
        )
      end
    end

    context 'when there are no matching records' do
      let(:matching_pool) { [] }
      let(:status) { 0 }

      it 'should return nothing' do
        expect(subject).to be_empty
      end
    end
  end
end
