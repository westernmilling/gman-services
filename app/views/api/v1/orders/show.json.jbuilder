json.order_number order_reference.OrderNumber
json.order_key order_reference.FeedXrefKey
json.quantity_shipped order_reference.order.quantity_shipped
json.ship_date order_reference.ShipDate.to_s(:iso8601)
json.status order_reference.status
json.warehouse_id order_reference.WarehouseId
json.uuid order_reference.UuidHeader
