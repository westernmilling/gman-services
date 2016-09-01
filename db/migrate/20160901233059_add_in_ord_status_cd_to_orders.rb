class AddInOrdStatusCdToOrders < ActiveRecord::Migration
  return if Order
            .connection
            .class
            .to_s
            .include?('Relativity')

  def change
    @connection = Order.connection

    add_column :InvCustomerOrders_Open_MainInfo, :InOrd_StatusCd, :integer
  end
end
