class CreateMovementTypesViews < ActiveRecord::Migration
  return if Rails.env == 'production'

  using(:grossman)

  def up
    self.connection.execute 'CREATE OR REPLACE VIEW MovementTypes AS
SELECT
  movement_description AS MovementDescription
  , movement_cd AS MovementCd
FROM
  movement_types'
  end
#
  def down
    self.connection.execute "DROP VIEW IF EXISTS MovementTypes;"
  end
end
