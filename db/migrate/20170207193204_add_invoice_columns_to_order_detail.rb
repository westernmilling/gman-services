class AddInvoiceColumnsToOrderDetail < ActiveRecord::Migration
  def change
    return if Order::Line
              .connection
              .class
              .to_s
              .include?('Relativity')

    @connection = Order::Line.connection

    add_column :InvCustomerOrders_Open_Detail,
               :InOrd_GrossInvoiceAmount,
               :decimal,
               precision: 13, scale: 4
    add_column :InvCustomerOrders_Open_Detail,
               :InOrd_InvoiceDate,
               :datetime
    add_column :InvCustomerOrders_Open_Detail,
               :InOrd_Invoice,
               :integer
  end
end
