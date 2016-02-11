class CreateMovementTypesViews < ActiveRecord::Migration
  return if MovementType.connection.class.to_s.include?('Relativity')

  def up
    MovementType.connection.execute('
    CREATE OR REPLACE VIEW MovementTypes AS
      SELECT
        movement_description AS MovementDescription
        , movement_cd AS MovementCd
      FROM
        movement_types
    ')
  end

  def down
    MovementType.connection.execute('DROP VIEW IF EXISTS MovementTypes;')
  end
end
