class Commodity
  class UnitOfMeasure < ActiveRecord::Base
    establish_connection "grossman_#{Rails.env}".to_sym

    self.primary_key = 'CommUOMId'
    self.table_name = 'CommodityUOM'

    def self.column_names
      %w{
        CommUOMId
        CommUOMDescription
      }
    end
  end
end
