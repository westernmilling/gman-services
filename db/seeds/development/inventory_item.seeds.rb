10.times do
  InventoryItem.create(
      item_id: Faker::Number.number(4),
      in_item_description: Faker::Name.first_name
  )
end
