require 'factory_girl_rails'

movement_type = FactoryGirl.create(:movement_type)
10.times do
  customer = FactoryGirl.create(:customer)
  driver = FactoryGirl.create(:driver)
  driver.DriverId = driver.id
  driver.save
  FactoryGirl.create(:driver_commission_history,
                     DriverId: driver.id,
                     CustomerName: customer.customer_name,
                     CustomerId: customer.customer_id,
                     MovementCd: movement_type.movement_cd)
end
