class CreateTruckingDriversViews < ActiveRecord::Migration
  using(:grossman)

  def up
    self.connection.execute 'CREATE OR REPLACE VIEW Trucking_Drivers AS
  SELECT
    driver_number AS DriverID
  , first_name AS FirstName
  , last_name AS LastName
  , driver_type AS DriverType
  FROM
    drivers'
  end

  def down
    self.connection.execute "DROP VIEW IF EXISTS Trucking_Drivers;"
  end
end
