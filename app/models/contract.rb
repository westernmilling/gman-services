class Contract < ActiveRecord::Base
  establish_connection "grossman_#{Rails.env}".to_sym

  belongs_to :commodity, foreign_key: :CommodityId
  belongs_to :customer, foreign_key: :CustomerId
  belongs_to :unit_of_measure,
             class_name: Commodity::UnitOfMeasure,
             foreign_key: :CommUOMId

  scope :commodity_id_eq,
        ->(commodity_id) { where("Contract.CommodityId = #{commodity_id}") }
  scope :customer_id_eq,
        ->(customer_id) { where("Contract.CustomerId = '#{customer_id}'") }

  self.primary_key = 'ContractId'
  self.table_name = 'Contract'

  def self.default_scope
    includes(:commodity, :customer, :unit_of_measure)
      .joins(:commodity, :customer, :unit_of_measure)
  end

  def self.column_names
    %w{
      CustomerId
      CommodityId
      ContractId
      CommUOMId
      LocationId
      CONT_ContractDate
      CONT_ContractNumber
      CONT_ContractSub
      CONT_ContractType
      CONT_DeliveredBushels
      CONT_FreightAdjustment
      CONT_Quantity
      CONT_Price
      CONT_FromDate
      CONT_ToDate
      Inv_ContractId
    }
  end

  # def self.column_names
  #   %w{
  #     CustomerId
  #     CommodityId
  #     ContractId
  #     CommUOMId
  #     LocationId
  #     CONT_ContractDate
  #     CONT_ContractNumber
  #     CONT_ContractSub
  #     CONT_ContractType
  #     CONT_Quantity
  #     CONT_DeliveredBushels
  #     CONT_Price
  #     CONT_FreightAdjustment
  #     CONT_FromDate
  #     CONT_ToDate
  #     Inv_ContractId
  #   }
  # end

  def self.ransackable_scopes(_auth_object = nil)
    [:commodity_id_eq, :customer_id_eq]
  end
end
