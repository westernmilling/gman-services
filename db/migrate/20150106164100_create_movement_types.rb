class CreateMovementTypes < ActiveRecord::Migration
  return if MovementType.connection.class.to_s.include?('Relativity')

  def change
    @connection = MovementType.connection

    create_table :MovementTypes do |t|
      t.string :MovementDescription
      t.integer :MovementCd

      t.timestamps
    end
  end
end
