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
    end
  end
end
