class CreateTruckingDriversCommissionsHistoryViews < ActiveRecord::Migration
  return if Rails.env == 'production'
  
  using(:grossman)

  def up
    self.connection.execute 'CREATE OR REPLACE VIEW Trucking_Drivers_Commissions_History AS
SELECT
  driver_id AS DriverId
, backhauls AS Backhauls
, freight_revenue AS FreightRevenue
, customer_id AS CustomerId
, delivery_date AS DeliveryDate
, driver_rate AS DriverRate
, freight_bill_number AS FreightBillNumber
, fuel_surcharge AS FuelSurcharge
, layover AS Layover
, movement_type AS MovementType
, movement_cd AS MovementCd
, other_hour_dollars AS OtherHourDollars
, order_number_text AS OrderNumberText
, origin_name AS OriginName
, paid_date AS PaidDate
, revenue AS Revenue
, split_rate AS SplitRate
, total_freight_revenue AS TotalFreightRevenue
, drvrcomh_key AS DrvrcomhKey
FROM
  driver_commission_histories;
'
  end

  def down
    self.connection.execute "DROP VIEW IF EXISTS Trucking_Drivers_Commissions_History;"
  end
end
