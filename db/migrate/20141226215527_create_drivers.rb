# CreateDrivers
class CreateDrivers < ActiveRecord::Migration
  using(:grossman)

  def change
    create_table :drivers do |t|
      t.integer :driver_number
      t.string :first_name
      t.string :last_name
      t.string :driver_type

      t.timestamps
    end
    view
  end

  def view
    create_view :Trucking_Drivers,
                'SELECT
              driver_number AS DriverID
            , first_name AS FirstName
            , last_name AS LastName
            , driver_type AS DriverType
          FROM
            drivers'
  end
end
