FactoryGirl.define do
  factory :movement_type do
    MovementCd { Faker::Number.number(2) }
    MovementDescription 'WALKING FLOOR'
  end
end
