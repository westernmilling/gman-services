FactoryGirl.define do
  factory :customer do
    sequence(:Name) { |x| "#{Faker::Company.name} #{x}" }
    sequence(:CustomerId) { |x| 100_000 + x }
  end
end
