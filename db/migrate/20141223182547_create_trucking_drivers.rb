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
    create_view :get_drivers,
                'SELECT
                DriverID
              , FirstName
              , LastName
            FROM
              Trucking_Drivers
            WHERE
              DriverType = "DR"'
  end
end
