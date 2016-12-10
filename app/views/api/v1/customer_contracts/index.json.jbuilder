json.array! customer_contracts do |customer_contract|
  json.customer_id customer_contract.CustomerId
  json.contract_id customer_contract.InvContractId
  json.location_id customer_contract.LocationId
  json.contract_type customer_contract.contract_type
end
