class CreateCustomerTable < ActiveRecord::Migration
  return if Customer.connection.class.to_s.include?('Relativity')

  def change
    @connection = Customer.connection

    create_table :customer_table do |t|
      t.string :customer_name
      t.integer :customer_id

      t.timestamps
    end
  end
end
