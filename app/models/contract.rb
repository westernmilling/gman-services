class Contract < ActiveRecord::Base
  establish_connection "grossman_#{Rails.env}".to_sym

  self.primary_key = 'ContractId'
  self.table_name = 'Contract'

  TYPE_MAP = {
    'P' => 'Purchase',
    'S' => 'Sale'
  }.freeze

  belongs_to :commodity, foreign_key: :CommodityId
  belongs_to :customer, foreign_key: :CustomerId
  belongs_to :unit_of_measure,
             class_name: Commodity::UnitOfMeasure,
             foreign_key: :CommUOMId

  scope :commodity_id_eq,
        ->(value) { where("Contract.CommodityId = #{value}") }
  scope :contract_type_eq,
        ->(value) { where("Contract.CONT_ContractType = '#{value}'") }
  scope :customer_id_eq,
        ->(value) { where("Contract.CustomerId = '#{value}'") }
  scope :inv_contract_id_eq,
        ->(value) { where("Contract.Inv_ContractId = #{value}") }
  scope :location_id_eq,
        ->(value) { where("Contract.LocationId = #{value}") }

  def contract_type
    TYPE_MAP[self.ContractType.strip]
  end

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
      CONT_Price
      CONT_Quantity
      CONT_FromDate
      CONT_ToDate
      Inv_ContractId
    }
  end

  def self.ransackable_scopes(_auth_object = nil)
    [
      :commodity_id_eq,
      :contract_type_eq,
      :customer_id_eq,
      :inv_contract_id_eq,
      :location_id_eq
    ]
  end
end
