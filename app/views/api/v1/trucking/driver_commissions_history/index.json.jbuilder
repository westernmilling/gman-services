json.array! commissions do |commission|
  json.back_hauls commission.Backhauls
  if commission.customer
    json.customer_id commission.CustomerId
    json.customer_name commission.customer.Name.strip
  else
    json.customer_id nil
    json.customer_name nil
  end
  json.delivery_date commission.DeliveryDate.to_s(:iso8601)
  json.driver_name commission.driver.name
  json.driver_number commission.DriverId.to_i
  json.driver_rate commission.DriverRate
  json.driver_commission_history_key commission.DrvrcomhKey
  json.freight_bill_number commission.FreightBillNumber.to_s.strip
  json.freight_revenue commission.FreightRevenue
  json.fuel_surcharge commission.FuelSurcharge
  json.layover commission.Layover
  json.movement_cd commission.movement_type.MovementCd
  json.movement_type commission.movement_type.MovementDescription.strip
  json.other_hour_dollars commission.OtherHourDollars
  json.order_number commission.OrderNumberText.strip
  json.origin_name commission.OriginName.strip
  json.paid_date commission.PaidDate.to_s(:iso8601)
  json.revenue commission.Revenue
  json.split_rate commission.SplitRate
  json.total_freight_revenue commission.TotalFreightRevenue
end
