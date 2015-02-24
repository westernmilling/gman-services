class CreateLocalCustomers < ActiveRecord::Migration
  return if Rails.env == 'production'

  using(:grossman)
  def change
    create_table :local_customers do |t|
      t.string :customer_name
      t.integer :customer_id

      t.timestamps
    end
  end
end
