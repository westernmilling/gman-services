class AddOrderKeyToOrderLines < ActiveRecord::Migration
  def change
    return if Order::Line
              .connection
              .class
              .to_s
              .include?('Relativity')

    @connection = Order::Line.connection

    add_column :InvCustomerOrders_Open_Detail,
               :OrderKey,
               :string,
               null: false
  end
end
