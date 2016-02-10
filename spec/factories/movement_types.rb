FactoryGirl.define do
  factory :movement_type, class: MovementType do
    movement_cd { Faker::Number.number(2) }
    movement_description 'WALKING FLOOR'
  end
end
