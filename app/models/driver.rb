class Driver < ActiveRecord::Base
  establish_connection "grossman_#{Rails.env}".to_sym

  self.primary_key = 'DriverId'
  self.table_name = 'Trucking_Drivers'

  def self.default_scope
    select(column_names.map(&:to_s))
  end

  def self.column_names
    %w{
      DriverId
      FirstName
      LastName
      DriverType
      SubHaulerFg
      ActiveFg
    }
  end
end
