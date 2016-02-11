FactoryGirl.define do
  factory :inventory_item, class: InventoryItem do
    ItemId Faker::Number.number(4)
    InItem_Description Faker::Commerce.product_name
  end
end
