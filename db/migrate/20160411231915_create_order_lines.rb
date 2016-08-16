class CreateOrderLines < ActiveRecord::Migration
  return if Order::Line
            .connection
            .class
            .to_s
            .include?('Relativity')

  def change
    @connection = Order::Line.connection

    create_table :InvCustomerOrders_Open_Detail, id: false do |t|
      t.string :ItemId, null: false
      t.decimal :InOrd_QtyShipped, null: false
      t.string :InOrd_WareShipToOrderKey, null: false
    end
  end
end
