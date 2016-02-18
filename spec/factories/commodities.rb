FactoryGirl.define do
  factory :commodity do
    association :unit_of_measure, factory: :commodity_unit_of_measure
    sequence(:CommodityId) { |x| 1_000 + x }
    sequence(:COMM_Description) { |x| "#{Faker::Lorem.word} #{x}" }
    COMM_ConversionFactor { [56, 60, 2000].sample }
  end
end
