FactoryGirl.define do
  factory :order_line, class: 'Order::Line' do
    sequence(:OrderKey) { |x| 1_000_000 + x }
    InOrd_QtyShipped { 0 }
  end
end
