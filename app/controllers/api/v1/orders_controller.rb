module Api
  module V1
    class OrdersController < Api::BaseController
      def show
        order_reference = Order::Reference
                          .where(UuidHeader: params[:id])
                          .to_a
                          .first

        if order_reference
          render :show, locals: { order_reference: order_reference }
        else
          render text: "Order::Reference with UUID #{params[:id]} not found",
                 status: 404
        end
      end

      def index
        order_references = Order::Reference.where(search_query)

        render :index, locals: { order_references: order_references }
      end

      private
      
      def search_query
        OrderQuery.new(warehouse_id: params[:warehouse_id],
                       order_number: params[:order_number])
                  .to_query
      end
    end
  end
end
