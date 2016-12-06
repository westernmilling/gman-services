json.ignore_nil!
json.order_number order_reference.OrderNumber
json.order_key order_reference.FeedXrefKey
json.carrier_id order_reference.order.carrier_id
json.quantity_shipped order_reference.order.quantity_shipped
json.ship_date order_reference.ShipDate.to_date.to_s(:iso8601)
json.ship_time order_reference.order.InOrd_ShipTime.strftime('%H:%M')
json.status order_reference.order.status
json.warehouse_id order_reference.WarehouseId
json.uuid order_reference.UuidHeader
json.lines order_reference.order.lines do |order_line|
  json.item_number order_line.ItemId.strip
  json.item_price order_line.InOrd_TotalPrice
  json.contract do
    if order_line.contract
      json.contract_id order_line.contract.ContractId
    else
      json.nil!
    end
  end
end
