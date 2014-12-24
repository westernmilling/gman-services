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
  TruckingDrivers.create(
                          :DriverId => Faker::Number.number(4),
                          :FirstName => Faker::Name.first_name,
                          :LastName => Faker::Name.last_name,
                          :DriverType => 'DR'
                          )
end
