Driver.create(
  DriverNumber: Faker::Number.number(4),
  FirstName: Faker::Name.first_name,
  LastName: Faker::Name.last_name,
  DriverType: 'DR'
)
