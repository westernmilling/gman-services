json.array! pick_up_orders do |pick_up_order|
  json.contract_id pick_up_order.ContractId
  json.contract_location_id pick_up_order.ContractLocationId
  json.load_number pick_up_order.LoadNumber
  json.origin pick_up_order.Origin
  json.origin_state pick_up_order.OriginState
  json.origin_weight_certificate pick_up_order.OriginWeightCertificate
  json.origin_tare_weight pick_up_order.OriginTareWeight
  json.origin_gross_weight pick_up_order.OriginGrossWeight
  json.origin_net_weight pick_up_order.OriginNetWeight
  json.pickup_type pick_up_order.pickup_type
  json.purchase_customer_id pick_up_order.PurchaseCustomerId.to_s
  json.release_prefix pick_up_order.ReleasePrefix
  json.release_load_number pick_up_order.ReleaseLoadNumber
  json.release_number pick_up_order.release_number
  json.ship_date pick_up_order.ShipDate
  json.status pick_up_order.status
  json.contract do
    json.contract_id pick_up_order.contract.Inv_ContractId
    json.commodity_id pick_up_order.contract.CommodityId.to_i
  end
end
