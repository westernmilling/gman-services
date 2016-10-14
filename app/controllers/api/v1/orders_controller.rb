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
        order_references = Order::Reference.ransack(ransack_query).result

        render :index, locals: { order_references: order_references }
      end

      private

      def ransack_query
        OrderQuery.new(params.slice(:warehouse_id_eq, :order_number_eq))
                  .to_ransack_query
      end
    end
  end
end
