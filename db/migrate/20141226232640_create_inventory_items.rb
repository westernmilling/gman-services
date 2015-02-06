class CreateInventoryItems < ActiveRecord::Migration
  return if Rails.env == 'production'
  
  using(:grossman)
  
  def change
    create_table :inventory_items do |t|
      t.integer :item_id
      t.string :in_item_description

      t.timestamps
    end
  end
end
