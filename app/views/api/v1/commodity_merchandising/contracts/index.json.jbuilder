json.array! contracts do |contract|
  json.balance contract.balance
  json.contract_id contract.ContractId
  json.customer do
    json.customer_id contract.customer.CustomerId
    json.name contract.customer.Name
  end
  json.commodity_id contract.CommodityId.to_i
  json.inv_contract_id contract.Inv_ContractId
  json.location_id contract.LocationId.to_i
  json.contract_number contract.CONT_ContractNumber
  json.price contract.CONT_Price.to_f
  json.freight_adjustment contract.CONT_FreightAdjustment.to_f
  json.commodity do
    json.commodity_id contract.commodity.CommodityId
    json.description contract.commodity.COMM_Description.strip
    json.conversion_factor contract.commodity.COMM_ConversionFactor
  end
  json.unit_of_measure do
    json.uom_id contract.unit_of_measure.CommUOMId
    json.description contract.unit_of_measure.CommUOMDescription.strip
  end
  json.contract_date contract.CONT_ContractDate
  json.contract_type contract.contract_type
  json.quantity contract.CONT_Quantity.to_f
  json.delivered_quantity contract.CONT_DeliveredBushels.to_f
  json.from_date contract.CONT_FromDate
  json.to_date contract.CONT_ToDate
end
