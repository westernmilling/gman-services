
FactoryGirl.define do
  factory :trucking_drivers do
    DriverId Faker::Number.number(4)
    FirstName Faker::Name.first_name
    LastName Faker::Name.last_name
  end
end
