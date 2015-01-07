Octopus.using(:grossman) do
  10.times do
    Driver.create(
                  :driver_number => Faker::Number.number(4),
                  :first_name => Faker::Name.first_name,
                  :last_name => Faker::Name.last_name,
                  :driver_type => 'DR'
                  )
  end
end