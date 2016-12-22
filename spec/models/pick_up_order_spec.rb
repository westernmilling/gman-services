require 'rails_helper'

RSpec.describe PickUpOrder, type: :model do
  it do
    is_expected
      .to have_one(:contract)
      .with_foreign_key([:Inv_ContractId, :LocationId])
      .with_primary_key([:ContractId, :ContractLocationId])
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
          ReleasePrefix
          Origin
          OriginState
          OriginWeightCertificate
          OriginGrossWeight
          OriginTareWeight
          OriginNetWeight
          PickupType
          PurchaseCustomerId
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
