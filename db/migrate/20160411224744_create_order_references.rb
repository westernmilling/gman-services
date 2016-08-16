class CreateOrderReferences < ActiveRecord::Migration
  return if Order::Reference
            .connection
            .class
            .to_s
            .include?('Relativity')

  def change
    @connection = Order::Reference.connection

    create_table :order_references do |t|
      t.integer :FeedXrefKey, null: false
      t.date :ShipDate, null: false
      t.string :UuidHeader, null: false

      t.timestamps
    end
  end
end
