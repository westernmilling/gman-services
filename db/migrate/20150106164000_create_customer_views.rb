class CreateCustomerViews < ActiveRecord::Migration
  return if Rails.env == 'production'

  using(:grossman)

  def up
    self.connection.execute 'CREATE OR REPLACE VIEW Customers AS
SELECT
  customer_name AS Name
, customer_id AS CustomerId
FROM
  local_customers'
  end
#
  def down
    self.connection.execute "DROP VIEW IF EXISTS Customers;"
  end
end
