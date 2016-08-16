class CreateOrderReferences < ActiveRecord::Migration
  return if Order::Reference
            .connection
            .class
            .to_s
            .include?('Relativity')

  def change
    @connection = Order::Reference.connection

    create_table :InvCustomerOrders_CrossReference, id: false do |t|
      t.string :FeedXrefKey, null: false
      t.integer :OrderNumber, null: false
      t.datetime :ShipDate, null: false
      t.integer :WarehouseId, null: false
      t.string :UuidHeader, null: false
    end
  end
end
