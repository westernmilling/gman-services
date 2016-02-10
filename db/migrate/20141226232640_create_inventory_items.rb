class CreateInventoryItems < ActiveRecord::Migration
  return if InventoryItem.connection.class.to_s.include?('Relativity')

  def change
    @connection = InventoryItem.connection

    create_table :inventory_items do |t|
      t.integer :item_id
      t.string :in_item_description

      t.timestamps
    end
  end
end
