FactoryGirl.define do
  factory :driver_commission_history do
    association :customer
    association :driver
    association :movement_type
    Backhauls { Faker::Number.number(4) }
    FreightRevenue { Faker::Number.number(4) }
    DeliveryDate { Date.new(2014, 1, 1) }
    DriverRate { Faker::Number.number(4) }
    FreightBillNumber { Faker::Number.number(4) }
    FuelSurcharge { Faker::Number.number(4) }
    Layover 'layover'
    OtherHourDollars { Faker::Number.number(4) }
    OrderNumberText { Faker::Number.number(4) }
    OriginName 'ORIGIN NAME'
    PaidDate Date.new(2014, 0o1, 0o1)
    Revenue { Faker::Number.number(4) }
    SplitRate { Faker::Number.number(4) }
    TotalFreightRevenue { Faker::Number.number(4) }
    DrvrcomhKey { "#{Faker::Number.number(5)} #{Faker::Number.number(8)}" }
  end
end
