class CreateDrivers < ActiveRecord::Migration
  return if Driver.connection.class.to_s.include?('Relativity')

  def change
    @connection = Driver.connection

    create_table :drivers do |t|
      t.integer :driver_number
      t.string :first_name
      t.string :last_name
      t.string :driver_type
      t.integer :active_fg
      t.integer :sub_hauler_fg

      t.timestamps
    end
  end
end
