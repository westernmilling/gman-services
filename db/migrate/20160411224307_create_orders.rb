class CreateOrders < ActiveRecord::Migration
  return if Order
            .connection
            .class
            .to_s
            .include?('Relativity')

  def change
    @connection = Contract.connection

    create_table :orders do |t|

      t.timestamps
    end
  end
end
