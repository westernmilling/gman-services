FactoryGirl.define do
  factory :order_line, class: 'Order::Line' do
    InOrd_QtyShipped { 0 }
  end
end
