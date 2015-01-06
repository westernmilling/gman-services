# CreateDriverViews
class CreateTruckingDriversViews < ActiveRecord::Migration
  using(:grossman)

  def change
    create_view :Trucking_Drivers,'
SELECT
  driver_number AS DriverID
, first_name AS FirstName
, last_name AS LastName
, driver_type AS DriverType
FROM
  drivers'
  end
end
