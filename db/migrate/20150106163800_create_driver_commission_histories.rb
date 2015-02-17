class CreateDriverCommissionHistories < ActiveRecord::Migration
  return if Rails.env == 'production'
  
  using(:grossman)
  def change
    create_table :driver_commission_histories do |t|
      t.integer :driver_id, :foreign_key => false
      t.string :backhauls
      t.integer :freight_revenue
      t.integer :customer_id, :foreign_key => false
      t.date :delivery_date
      t.integer :driver_rate
      t.integer :freight_bill_number
      t.integer :fuel_surcharge
      t.string :layover
      t.string :movement_type
      t.integer :other_hour_dollars
      t.string :order_number_text
      t.string :origin_name
      t.date :paid_date
      t.integer :revenue
      t.integer :split_rate
      t.integer :total_freight_revenue
      t.string :drvrcomh_key
      t.timestamps
    end
  end
end
