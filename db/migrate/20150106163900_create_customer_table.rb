class CreateCustomerTable < ActiveRecord::Migration
  def change
    return if Customer.connection.class.to_s.include?('Relativity')

    @connection = Customer.connection

    create_table :Customers do |t|
      t.string :Name
      t.integer :CustomerId

      t.timestamps
    end
  end
end
