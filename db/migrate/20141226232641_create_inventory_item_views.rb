class CreateInventoryItemViews < ActiveRecord::Migration
  return if InventoryItem.connection.class.to_s.include?('Relativity')

  def up
    InventoryItem.connection.execute('
    CREATE OR REPLACE VIEW InvItems AS
      SELECT
        item_id AS ItemId
      , in_item_description AS InItem_Description
      FROM
        inventory_items
    ')
  end

  def down
    InventoryItem.connection.execute('DROP VIEW IF EXISTS InvItems;')
  end
end
