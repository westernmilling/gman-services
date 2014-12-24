# CreateTruckingDrivers
class CreateTruckingDrivers < ActiveRecord::Migration
  using(:grossman)

  def change
    create_table :Trucking_Drivers do |t|
      t.integer :DriverId
      t.string :FirstName
      t.string :LastName
      t.string :DriverType

      t.timestamps
    end
    view
  end

  def view
    create_view :drivers_view,
                'SELECT
                DriverID AS driver_id
              , FirstName AS first_name
              , LastName AS last_name
            FROM
              Trucking_Drivers
            WHERE
              DriverType = "DR"'
  end
end
