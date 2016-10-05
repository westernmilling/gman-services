FactoryGirl.define do
  factory :order do
    sequence(:InOrd_CarrierCustomer) { |x| x * 100 }

    OrderKey { Faker::Number.number(10) }
    InOrd_CarrierCustomerSub { 0 }
    InOrd_OrderNo { Faker::Number.number(6) }
    InOrd_ShipDate { self.InOrd_ShipTime.to_date }
    InOrd_ShipTime { Time.zone.now }
    InOrd_StatusCd { rand(4) }
    InOrd_WareShipToOrderKey { Faker::Number.number(10) }
    WarehouseId { Faker::Number.number(4) }
  end
end
