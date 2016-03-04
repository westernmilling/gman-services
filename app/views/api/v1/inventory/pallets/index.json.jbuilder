json.array! pallets do |pallet|
  # Letter, Number, Z=Separator, Symbol, Punctuation
  # http://www.regular-expressions.info/unicode.html
  json.pallet_id pallet.PalletId[/[\p{L}\p{N}\p{Z}\p{S}\p{P}]*/]
  json.warehouse_id pallet.WarehouseId
  json.item_id pallet.ItemId.strip
  json.pallet_number pallet.InPallet_PalletNo.to_i
  json.order_number pallet.InPallet_OrderNo.to_i
  json.transation_date pallet.InPallet_TranDate
  json.transation_time pallet.InPallet_TranTime.to_s(:iso8601)
  json.transaction_type_code pallet.InPallet_TranTypeCd.to_i
  json.status_code pallet.InPallet_StatusCd
  json.tag_type_code pallet.InPallet_TagTypeCd
  json.location pallet.InPallet_Location
  json.area pallet.InPallet_Area
  json.sequence_number pallet.InPallet_SequenceNo
  json.storage_date pallet.InPallet_StorageDateCymd
end
