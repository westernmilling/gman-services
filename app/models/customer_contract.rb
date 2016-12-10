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
  scope :customer_id, (
    lambda do |values|
      values_string = values.split(',').map { |value| "'#{value}'" }.join(', ')
      where("Contract_Customers.CustomerId IN (#{values_string})")
    end
  )

  def contract_type
    Contract::TYPE_MAP[self.ContractType.strip]
  end

  def self.column_names
    %w{
      CustomerId
      InvContractId
      LocationId
      ContractType
    }
  end

  def self.ransackable_scopes(_auth_object = nil)
    [
      :customer_id
    ]
  end
end
