class CreateContractsView < ActiveRecord::Migration
  return if Contract.connection.class.to_s.include?('Relativity')

  def up
    Contract.connection.execute('
    CREATE OR REPLACE VIEW Contract AS
      SELECT
        contract_id AS ContractId
      , customer_id AS CustomerId
      , commodity_id AS CommodityId
      , cont_contract_number AS CONT_ContractNumber
      , cont_contract_type AS CONT_ContractType
      , cont_contract_date AS CONT_ContractDate
      , cont_quantity AS CONT_Quantity
      , cont_delivered_bushels AS CONT_DeliveredBushels
      , cont_price AS CONT_Price
      , cont_freightadjustment AS CONT_FreightAdjustment
      , cont_from_date AS CONT_FromDate
      , cont_to_date AS CONT_ToDate
      FROM
        contracts
    ')
  end

  def down
    Contract.connection.execute('DROP VIEW IF EXISTS Contract;')
  end
end
