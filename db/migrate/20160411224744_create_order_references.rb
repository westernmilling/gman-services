class CreateOrderReferences < ActiveRecord::Migration
  return if OrderReference
            .connection
            .class
            .to_s
            .include?('Relativity')

  def change
    @connection = Contract.connection

    create_table :order_references do |t|

      t.timestamps
    end
  end
end
