require 'factory_girl_rails'
Octopus.using(:grossman) do
  movement_type = FactoryGirl.create(:movement_type)
  10.times do
    customer = FactoryGirl.create(:local_customer)
    driver = FactoryGirl.create(:driver)
    driver.driver_number = driver.id
    driver.save
    FactoryGirl.create(:driver_commission_history,
                       :driver_id => driver.id,
                       :customer_name => customer.customer_name,
                       :customer_id => customer.customer_id,
                       :movement_cd => movement_type.movement_cd)
  end
end
