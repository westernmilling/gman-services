class Commodity < ActiveRecord::Base
  establish_connection "grossman_#{Rails.env}".to_sym

  belongs_to :unit_of_measure,
             class_name: Commodity::UnitOfMeasure,
             foreign_key: :COMM_CommUOMId

  scope :commodity_id_eq,
        ->(commodity_id) { where("Commodity.CommodityId = #{commodity_id}") }

  self.primary_key = 'CommodityId'
  self.table_name = 'Commodity'

  def self.default_scope
    includes(:unit_of_measure).joins(:unit_of_measure)
  end

  def self.column_names
    %w{
      CommodityId
      COMM_Description
      COMM_CommUOMId
      COMM_ConversionFactor
    }
  end

  def self.ransackable_scopes(_auth_object = nil)
    [:commodity_id_eq]
  end
end
