class AddTotalPriceToOrderLines < ActiveRecord::Migration
  def change
    return if Order::Line
              .connection
              .class
              .to_s
              .include?('Relativity')

    @connection = Order::Line.connection

    add_column :InvCustomerOrders_Open_Detail,
               :InOrd_TotalPrice,
               :decimal,
               scale: 4,
               precision: 13,
               null: false
  end
end
