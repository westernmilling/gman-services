class CreateOrderLines < ActiveRecord::Migration
  return if Order::Line
            .connection
            .class
            .to_s
            .include?('Relativity')

  def change
    @connection = Contract.connection

    create_table :order_lines do |t|

      t.timestamps
    end
  end
end
