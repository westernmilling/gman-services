class CreateCustomerViews < ActiveRecord::Migration
  return if Customer.connection.class.to_s.include?('Relativity')

  def up
    Customer.connection.execute('
    CREATE OR REPLACE VIEW Customers AS
      SELECT
        customer_name AS Name
      , customer_id AS CustomerId
      FROM
        customer_table
    ')
  end

  def down
    Customer.connection.execute('DROP VIEW IF EXISTS Customers;')
  end
end
