class CreateOrders < ActiveRecord::Migration
  def change
    return if Order
              .connection
              .class
              .to_s
              .include?('Relativity')

    @connection = Order.connection

    create_table :InvCustomerOrders_Open_MainInfo, id: false do |t|
      t.string :OrderKey, null: false
      t.integer :InOrd_OrderNo, null: false
      t.string :InOrd_WareShipToOrderKey, null: false
      t.integer :WarehouseId, null: false
    end
  end
end
