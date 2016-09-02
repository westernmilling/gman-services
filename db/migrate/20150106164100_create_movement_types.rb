class CreateMovementTypes < ActiveRecord::Migration
  def change
    return if MovementType.connection.class.to_s.include?('Relativity')

    @connection = MovementType.connection

    create_table :MovementTypes do |t|
      t.string :MovementDescription
      t.integer :MovementCd

      t.timestamps
    end
  end
end
