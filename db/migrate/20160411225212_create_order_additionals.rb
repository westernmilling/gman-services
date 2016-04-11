class CreateOrderAdditionals < ActiveRecord::Migration
  return if Order::Additional
            .connection
            .class
            .to_s
            .include?('Relativity')

  def change
    @connection = Contract.connection

    create_table :order_additionals do |t|

      t.timestamps
    end
  end
end
