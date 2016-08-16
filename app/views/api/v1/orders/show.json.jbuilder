json.order_number order_reference.OrderNumber
json.order_key order_reference.FeedXrefKey
json.quantity_shipped order_reference
                      .order
                      .lines
                      .map(&:InOrd_QtyShipped)
                      .inject(0, :+)
json.ship_date order_reference.ShipDate
json.warehouse_id order_reference.order.WarehouseId
json.uuid order_reference.UuidHeader
