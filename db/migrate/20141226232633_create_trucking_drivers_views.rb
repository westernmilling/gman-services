class CreateTruckingDriversViews < ActiveRecord::Migration
  return if Rails.env == 'production'
  
  using(:grossman)
  
  def up
    self.connection.execute 'CREATE OR REPLACE VIEW Trucking_Drivers AS
  SELECT
    driver_number AS DriverID
  , first_name AS FirstName
  , last_name AS LastName
  , driver_type AS DriverType
  , sub_hauler_fg AS SubHaulerFg
  , active_fg AS ActiveFg
  FROM
    drivers'
  end

  def down
    self.connection.execute "DROP VIEW IF EXISTS Trucking_Drivers;"
  end
end
