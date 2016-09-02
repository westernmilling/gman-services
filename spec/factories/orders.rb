FactoryGirl.define do
  factory :order do
    OrderKey { Faker::Number.number(10) }
    InOrd_OrderNo { Faker::Number.number(6) }
    InOrd_WareShipToOrderKey { Faker::Number.number(10) }
    InOrd_StatusCd { rand(4) }
    WarehouseId { Faker::Number.number(4) }
  end
end
