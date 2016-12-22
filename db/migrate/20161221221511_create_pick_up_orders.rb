class CreatePickUpOrders < ActiveRecord::Migration
  def change
    return if PickUpOrder
              .connection
              .class
              .to_s
              .include?('Relativity')

    @connection = PickUpOrder.connection

    create_table :InvPickUpOrders, id: false do |t|
      t.string :ContractId
      t.string :LocationId
      t.integer :LoadNumber
    end
  end
end
