class CreateDrivers < ActiveRecord::Migration
  def change
    return if Driver.connection.class.to_s.include?('Relativity')

    @connection = Driver.connection

    create_table :Trucking_Drivers do |t|
      t.integer :DriverId
      t.string :FirstName
      t.string :LastName
      t.string :DriverType
      t.integer :ActiveFg
      t.integer :SubHaulerFg

      t.timestamps
    end
  end
end
