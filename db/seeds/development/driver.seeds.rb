Octopus.using(:grossman) do
  10.times do
    Driver.create(
        :driver_number => Faker::Number.number(4),
        :first_name => Faker::Name.first_name,
        :active_fg => [true, false].sample,
        :last_name => Faker::Name.last_name,
        :sub_hauler_fg => [true, false].sample,
        :driver_type => 'DR'
                  )
  end
end
