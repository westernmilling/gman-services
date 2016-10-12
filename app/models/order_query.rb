class OrderQuery
  include ActiveModel::Model

  attr_accessor :warehouse_id, :order_number

  validates! :warehouse_id, length: { is: 2 }
  validates! :order_number, length: { is: 6 }

  def to_query
    valid? # This will trigger an error if parameters are invalid
    # I may be defeating the point of sanitizing here but the sanizitize method
    # wraps the query in quotes so I remove them after because Relativity
    # doesn't seem to be capable of handling that
    ActiveRecord::Base.sanitize(
      "WarehouseId = #{warehouse_id} AND OrderNumber = #{order_number}"
    )
                      .delete('\'')
  end
end
