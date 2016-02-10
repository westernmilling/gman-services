FactoryGirl.define do
  factory :driver, class: Driver do
    driver_number { Faker::Number.number(4) }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    active_fg { [true, false].sample }
    sub_hauler_fg { [true, false].sample }
    driver_type 'DR'
  end
end
