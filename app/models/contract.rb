require_relative 'concerns/contract'

class Contract < ActiveRecord::Base
  establish_connection "grossman_#{Rails.env}".to_sym

  self.primary_keys = :ContractId, :LocationId
  self.table_name = 'Contract'

  include Contract::Columns
  include Contract::Ransack

  TYPE_MAP = {
    'P' => 'Purchase',
    'S' => 'Sale'
  }.freeze

  belongs_to :commodity, foreign_key: :CommodityId
  belongs_to :customer, foreign_key: :CustomerId
  belongs_to :unit_of_measure,
             class_name: Commodity::UnitOfMeasure,
             foreign_key: :CommUOMId
  has_many :pick_up_orders,
           foreign_key: [:ContractId, :ContractLocationId],
           primary_key: [:Inv_ContractId, :LocationId]

  include Contract::Scopes

  def balance
    self.CONT_Quantity - self.CONT_DeliveredBushels
  end

  def contract_type
    TYPE_MAP[self.CONT_ContractType.strip]
  end

  def self.default_scope
    includes(:commodity, :customer, :unit_of_measure)
      .joins(:commodity, :customer, :unit_of_measure)
  end
end
