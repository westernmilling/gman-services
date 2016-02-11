FactoryGirl.define do
  factory :driver_commission_history do
    DriverId { Faker::Number.number(4) }
    Backhauls { Faker::Number.number(4) }
    FreightRevenue { Faker::Number.number(4) }
    CustomerId 0001
    DeliveryDate { Date.new(2014, 01, 01) }
    DriverRate { Faker::Number.number(4) }
    FreightBillNumber { Faker::Number.number(4) }
    FuelSurcharge { Faker::Number.number(4) }
    Layover 'layover'
    MovementCd 1
    OtherHourDollars { Faker::Number.number(4) }
    OrderNumberText { Faker::Number.number(4) }
    OriginName 'ORIGIN NAME'
    PaidDate Date.new(2014, 01, 01)
    Revenue { Faker::Number.number(4) }
    SplitRate { Faker::Number.number(4) }
    TotalFreightRevenue { Faker::Number.number(4) }
    DrvrcomhKey { "#{Faker::Number.number(5)} #{Faker::Number.number(8)}" }
  end
end
