class OrderQuery
  include ActiveModel::Model

  attr_accessor :warehouse_id_eq, :order_number_eq

  validates! :warehouse_id_eq, length: { is: 2 }
  validates! :order_number_eq, length: { is: 6 }

  def to_ransack_query
    valid? # This will trigger an exception if parameters are missing or invalid
    { warehouse_id_eq: warehouse_id_eq, order_number_eq: order_number_eq }
  end
end
