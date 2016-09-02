class AddInOrdStatusCdToOrders < ActiveRecord::Migration
  def change
    return if Order
              .connection
              .class
              .to_s
              .include?('Relativity')

    @connection = Order.connection

    add_column :InvCustomerOrders_Open_MainInfo, :InOrd_StatusCd, :integer
  end
end
