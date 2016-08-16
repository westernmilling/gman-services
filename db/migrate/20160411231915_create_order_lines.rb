class CreateOrderLines < ActiveRecord::Migration
  return if Order::Line
            .connection
            .class
            .to_s
            .include?('Relativity')

  def change
    @connection = Order::Line.connection

    create_table :order_lines do |t|
      t.string :ItemId, null: false
      t.decimal :InOrd_QtyShipped, null: false

      t.timestamps
    end
  end
end
