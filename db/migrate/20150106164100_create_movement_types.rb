class CreateMovementTypes < ActiveRecord::Migration
  return if MovementType.connection.class.to_s.include?('Relativity')

  def change
    @connection = MovementType.connection

    create_table :movement_types do |t|
      t.string :movement_description
      t.integer :movement_cd

      t.timestamps
    end
  end
end
