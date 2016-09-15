FactoryGirl.define do
  factory :driver do
    DriverId { Faker::Number.number(4).to_s }
    FirstName { Faker::Name.first_name }
    LastName { Faker::Name.last_name }
    ActiveFg { [true, false].sample }
    SubHaulerFg { [true, false].sample }
    DriverType 'DR'
  end
end
