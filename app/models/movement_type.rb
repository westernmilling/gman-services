class MovementType < ActiveRecord::Base
  establish_connection "grossman_#{Rails.env}".to_sym

  self.primary_key = 'MovementCd'
  self.table_name = 'MovementTypes'

  def self.default_scope
    select(column_names.map(&:to_s))
  end

  def self.column_names
    %w{
      MovementCd
      MovementDescription
    }
  end
end
