FactoryGirl.define do
  factory :customer do
    customer_name { "#{Faker::Name.first_name}, #{Faker::Name.last_name}" }
    customer_id { Faker::Number.number(4) }
  end
end
