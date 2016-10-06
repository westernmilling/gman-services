class AddCarrierFieldsToOrders < ActiveRecord::Migration
  def change
    return if Order
              .connection
              .class
              .to_s
              .include?('Relativity')

    @connection = Order.connection

    add_column :InvCustomerOrders_Open_MainInfo,
               :InOrd_CarrierCustomer,
               :integer,
               null: false
    add_column :InvCustomerOrders_Open_MainInfo,
               :InOrd_CarrierCustomerSub,
               :integer,
               null: false
  end
end
