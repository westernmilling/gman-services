class CreateInventoryItems < ActiveRecord::Migration
  def change
    return if InventoryItem.connection.class.to_s.include?('Relativity')

    @connection = InventoryItem.connection

    create_table :InvItems do |t|
      t.integer :ItemId
      t.string :InItem_Description

      t.timestamps
    end
  end
end
