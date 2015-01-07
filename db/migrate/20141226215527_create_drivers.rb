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
  end
end
