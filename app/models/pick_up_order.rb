class PickUpOrder < ActiveRecord::Base
  establish_connection "grossman_#{Rails.env}".to_sym

  self.primary_key = 'PickUpKey'
  self.table_name = 'InvPickUpOrders'

  belongs_to :contract,
             foreign_key: [:Inv_ContractId, :LocationId],
             primary_key: [:ContractId, :ContractLocationId]

  def self.column_names
    %w{
      ContractId
      ContractLocationId
      LoadNumber
    }
  end

  def to_s
    "#{self.ContractId}-#{self.ContractLocationId}-#{self.LoadNumber}"
  end
end
