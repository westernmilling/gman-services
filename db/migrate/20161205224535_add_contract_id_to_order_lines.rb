class AddContractIdToOrderLines < ActiveRecord::Migration
  def change
    return if Order::Line
              .connection
              .class
              .to_s
              .include?('Relativity')

    @connection = Order::Line.connection

    add_column :InvCustomerOrders_Open_Detail,
               :ContractId,
               :string
  end
end
