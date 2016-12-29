class CreateInventoryItems < ActiveRecord::Migration
  def change
    return if InventoryItem.connection.class.to_s.include?('Relativity')

    @connection = InventoryItem.connection

    create_table :InvItems, id: false do |t|
      t.string :ItemId
      t.string :InItem_Description
      t.integer :InItem_CommodityId
    end
  end
end
