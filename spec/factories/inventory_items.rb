FactoryGirl.define do
  factory :inventory_item, :class => InventoryItem do
    item_id Faker::Number.number(4)
    # uuid SecureRandom.uuid
    in_item_description Faker::Company.bs
  end
end
