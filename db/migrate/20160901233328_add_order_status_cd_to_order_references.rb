class AddOrderStatusCdToOrderReferences < ActiveRecord::Migration
  return if Order::Reference
            .connection
            .class
            .to_s
            .include?('Relativity')

  def change
    @connection = Order::Reference.connection

    add_column :InvCustomerOrders_CrossReference, :OrderStatusCd, :integer
  end
end
