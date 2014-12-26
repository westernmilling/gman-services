# This file should contain all the record creation needed to
# seed the database with its default values.
# The data can then be loaded with the rake db:seed
# (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create(
#                       [{ name: 'Chicago' },
#                       { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# puts 'creating drivers'
Octopus.using(:grossman) do
  Drivers.create(
      :driver_number => Faker::Number.number(4),
      :first_name => Faker::Name.first_name,
      :last_name => Faker::Name.last_name,
      :driver_type => 'DR'
  )
end
