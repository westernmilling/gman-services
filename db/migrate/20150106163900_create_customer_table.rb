class CreateCustomerTable < ActiveRecord::Migration
  return if Customer.connection.class.to_s.include?('Relativity')

  def change
    @connection = Customer.connection

    create_table :Customers do |t|
      t.string :Name
      t.integer :CustomerId

      t.timestamps
    end
  end
end
