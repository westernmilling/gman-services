require 'factory_girl_rails'
Octopus.using(:grossman) do
  10.times do
    driver = FactoryGirl.create(:driver)
    driver.driver_number = driver.id
    driver.save
    FactoryGirl.create(:driver_commission_history, :driver_id => driver.id)
  end
end
