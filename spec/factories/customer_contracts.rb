FactoryGirl.define do
  factory :customer_contract do
    sequence(:CustomerId) { |x| (100_000 + x).to_s }
    sequence(:InvContractId) { |x| "#{100_000 + x}00" }
    ContractType { %w{P S}.sample }
    LocationId { '1' }
  end
end
