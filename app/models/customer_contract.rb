class CustomerContract < ActiveRecord::Base
  establish_connection "grossman_#{Rails.env}".to_sym

  self.primary_key = 'CustomerId', 'InvContractId'
  self.table_name = 'Contract_Customers'

  belongs_to(
    :contract,
    lambda do
      where(
        [
          'Contract.LocationId = Contract_Customers.LocationId',
          'Contract.CONT_ContractType = Contract_Customers.ContractType'
        ].join(' AND ')
      )
    end,
    foreign_key: :InvContractId,
    primary_key: :Inv_ContractId
  )

  def self.column_names
    %w{
      CustomerId
      InvContractId
      LocationId
      ContractType
    }
  end
end
