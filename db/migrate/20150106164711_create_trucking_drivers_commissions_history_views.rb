class CreateTruckingDriversCommissionsHistoryViews < ActiveRecord::Migration
  using(:grossman)
  def change
    create_view :Trucking_Drivers_Commissions_History, '
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
, other_hour_dollars AS OtherHourDollars
, order_number_text AS OrderNumberText
, origin_name AS OriginName
, paid_date AS PaidDate
, revenue AS Revenue
, split_rate AS SplitRate
, total_freight_revenue AS TotalFreightRevenue
FROM
driver_commission_histories
'
  end
end
