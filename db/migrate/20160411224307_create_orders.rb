class CreateOrders < ActiveRecord::Migration
  return if Order
            .connection
            .class
            .to_s
            .include?('Relativity')

  def change
    @connection = Order.connection

    create_table :orders do |t|
      t.integer :OrderKey, null: false
      t.integer :InOrd_OrderNo, null: false
      t.string :InOrd_WareShipToOrderKey, null: false
      t.integer :WarehouseId, null: false

      t.timestamps
    end
  end
end
