class Contract < ActiveRecord::Base
  establish_connection "grossman_#{Rails.env}".to_sym

  scope :commodity_id_eq,
        ->(commodity_id) { where("CommodityId = #{commodity_id}") }

  self.primary_key = 'ContractId'
  self.table_name = 'Contract'

  def self.default_scope
    select(column_names.map(&:to_s))
  end

  def self.column_names
    %w{
      ContractId
      CustomerId
      CommodityId
      CONT_ContractNumber
      CONT_ContractType
      CONT_ContractDate
      CONT_Quantity
      CONT_DeliveredBushels
      CONT_Price
      CONT_FreightAdjustment
      CONT_FromDate
      CONT_ToDate
    }
  end

  def self.ransackable_scopes(_auth_object = nil)
    [:commodity_id_eq]
  end
end
