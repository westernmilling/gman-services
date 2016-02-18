require 'factory_girl_rails'

uoms = FactoryGirl.create_list(:commodity_unit_of_measure, 3)
commodities = []

5.times do
  commodities << FactoryGirl.create(:commodity, unit_of_measure: uoms.sample)
end

5.times do
  customer = FactoryGirl.create(:customer)
  10.times do
    FactoryGirl.create(:contract,
                       CommodityId: commodities.sample.CommodityId,
                       CustomerId: customer.CustomerId)
  end
end
