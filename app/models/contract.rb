require_relative 'concerns/contract'

class Contract < ActiveRecord::Base
  establish_connection "grossman_#{Rails.env}".to_sym

  self.primary_key = 'ContractId'
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

  include Contract::Scopes

  def contract_type
    TYPE_MAP[self.ContractType.strip]
  end

  def self.default_scope
    includes(:commodity, :customer, :unit_of_measure)
      .joins(:commodity, :customer, :unit_of_measure)
  end
end
