class CreateInventoryItemViews < ActiveRecord::Migration
  return if Rails.env == 'production'
  
  using(:grossman)

  def up
    self.connection.execute 'CREATE OR REPLACE VIEW InvItems AS
SELECT
  item_id AS ItemId
, in_item_description AS InItem_Description
FROM
  inventory_items'
  end

  def down
    self.connection.execute "DROP VIEW IF EXISTS InvItems;"
  end
end
