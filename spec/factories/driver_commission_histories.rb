FactoryGirl.define do
  factory :driver_commission_history, :class => DriverCommissionHistory do
    driver_id { Faker::Number.number(4) }
    backhauls { Faker::Number.number(4) }
    freight_revenue { Faker::Number.number(4) }
    customer_id 0001
    delivery_date { Date.new(2014, 01, 01) }
    driver_rate { Faker::Number.number(4) }
    freight_bill_number { Faker::Number.number(4) }
    fuel_surcharge { Faker::Number.number(4) }
    layover 'layover'
    movement_type 'MOVE TYPE'
    other_hour_dollars { Faker::Number.number(4) }
    order_number_text { Faker::Number.number(4) }
    origin_name 'ORIGIN NAME'
    paid_date Date.new(2014, 01, 01)
    revenue { Faker::Number.number(4) }
    split_rate { Faker::Number.number(4) }
    total_freight_revenue { Faker::Number.number(4) }
    drvrcomh_key { "#{Faker::Number.number(5)} #{Faker::Number.number(8)}" }
  end
end
