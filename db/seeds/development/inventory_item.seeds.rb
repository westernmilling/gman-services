10.times do
  InventoryItem.create(
    ItemId: Faker::Number.number(4),
    InItem_Description: Faker::Name.first_name
  )
end
