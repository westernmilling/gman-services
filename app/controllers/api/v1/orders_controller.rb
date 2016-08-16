module Api
  module V1
    class OrdersController < Api::BaseController
      def show
        order_reference = Order::Reference
                          .where(UuidHeader: params[:id])
                          .to_a
                          .first

        render :show, locals: { order_reference: order_reference }
      end
    end
  end
end
