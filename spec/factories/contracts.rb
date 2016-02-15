FactoryGirl.define do
  factory :contract do
    sequence(:CONT_ContractNumber) { |x| 100_000 + x }
    CommodityId { Faker::Number.between(1_000, 2_000) }
    CONT_ContractDate { Date.current }
    CONT_ContractType { %w{P S}.sample }
    CONT_Quantity { [50_000, 100_000].sample }
    CONT_DeliveredBushels { Faker::Number.between(0, self.CONT_Quantity) }
    CONT_FreightAdjustment { [0, 5, 6, 7].sample }
    CONT_FromDate { Date.current }
    CONT_ToDate { Date.current + 1.year }
    CONT_Price { Faker::Number.between(200, 400) }
    ContractId { "000#{self.CONT_ContractNumber}#{self.CONT_ContractType}" }
  end
end
