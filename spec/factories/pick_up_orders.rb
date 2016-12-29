FactoryGirl.define do
  factory :pick_up_order do
    sequence(:CarrierCustomerNumber) { |x| 1_000 + x }
    sequence(:ItemId) { |x| 10 + x }

    CarrierCustomerSub { '00' }
    FreightAmount { 0 }
    Origin { Faker::Address.city }
    OriginState { Faker::Address.state }
    OriginWeightCertificate { 0 }
    OriginGrossWeight { 0 }
    OriginTareWeight { 0 }
    OriginNetWeight { 0 }
    PickupType { 0 }
    PurchaseCustomerId { 0 }
    ShipDate { Time.zone.today }
    Shipper { Faker::Business.name }
    SplitFg { 'N' }
    SplitTicketNumber { 0 }
    Status { 0 }
    TicketLocationId { 0 }
  end
end
