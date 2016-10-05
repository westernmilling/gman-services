FactoryGirl.define do
  factory :order_reference, class: 'Order::Reference' do
    FeedXrefKey { Faker::Number.number(10) }
    OrderNumber { Faker::Number.number(6) }
    OrderStatusCd { rand(4) }
    ShipDate { Time.zone.today }
    WarehouseId { Faker::Number.number(4) }
    UuidHeader { SecureRandom.uuid }

    after :build do |order_reference, _evaluator|
      order_reference.order =
        build(:order,
              OrderKey: order_reference.FeedXrefKey,
              InOrd_OrderNo: order_reference.OrderNumber,
              InOrd_ShipTime: order_reference.ShipDate,
              InOrd_StatusCd: order_reference.OrderStatusCd,
              WarehouseId: order_reference.WarehouseId)
    end
  end
end
