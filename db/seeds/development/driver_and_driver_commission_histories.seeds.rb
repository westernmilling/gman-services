require 'factory_girl_rails'

movement_type = FactoryGirl.create(:movement_type)
10.times do
  customer = FactoryGirl.create(:customer)
  driver = FactoryGirl.create(:driver)
  driver.DriverId = driver.id
  driver.save
  FactoryGirl.create(:driver_commission_history,
                     DriverId: driver.id,
                     CustomerName: customer.Name,
                     CustomerId: customer.CustomerId,
                     MovementCd: movement_type.MovementCd)
end
