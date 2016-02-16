FactoryGirl.define do
  factory :commodity_unit_of_measure, class: 'Commodity::UnitOfMeasure' do
    sequence(:CommUOMId) { |x| x }
    sequence(:CommUOMDescription) { |x| "#{Faker::Lorem.word} #{x}" }
  end
end
