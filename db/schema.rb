# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150107233844) do

  create_view "Trucking_Drivers", "SELECT\n  driver_number AS DriverID\n, first_name AS FirstName\n, last_name AS LastName\n, driver_type AS DriverType\nFROM\n  drivers", :force => true
  create_view "Trucking_Drivers_Commissions_History", "SELECT\n  driver_id AS DriverId\n, backhauls AS Backhauls\n, freight_revenue AS FreightRevenue\n, customer_id AS CustomerId\n, delivery_date AS DeliveryDate\n, driver_rate AS DriverRate\n, freight_bill_number AS FreightBillNumber\n, fuel_surcharge AS FuelSurcharge\n, layover AS Layover\n, movement_type AS MovementType\n, other_hour_dollars AS OtherHourDollars\n, order_number_text AS OrderNumberText\n, origin_name AS OriginName\n, paid_date AS PaidDate\n, revenue AS Revenue\n, split_rate AS SplitRate\n, total_freight_revenue AS TotalFreightRevenue\nFROM\n  driver_commission_histories", :force => true
# Could not dump table "driver_commission_histories" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

# Could not dump table "drivers" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

end
