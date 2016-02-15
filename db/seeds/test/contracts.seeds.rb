require 'factory_girl_rails'

5.times do
  customer = FactoryGirl.create(:customer)
  10.times do
    FactoryGirl.create(:contract, CustomerId: customer.CustomerId)
  end
end
