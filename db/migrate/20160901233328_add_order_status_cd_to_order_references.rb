class AddOrderStatusCdToOrderReferences < ActiveRecord::Migration
  def change
    return if Order::Reference
              .connection
              .class
              .to_s
              .include?('Relativity')

    @connection = Order::Reference.connection

    add_column :InvCustomerOrders_CrossReference, :OrderStatusCd, :integer
  end
end
