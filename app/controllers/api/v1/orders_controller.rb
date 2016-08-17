module Api
  module V1
    class OrdersController < Api::BaseController
      def index
        render(
          :index,
          locals: { order_references: order_references }
        )
      end

      def show
        order_reference = Order::Reference
                          .where(UuidHeader: params[:id])
                          .to_a
                          .first

        render :show, locals: { order_reference: order_reference }
      end

      protected

      def search
        @_search ||= Order::Reference.ransack(params[:q])
      end

      def order_references
        @_order_references ||= Order::Reference.ship_date_eq('2016-08-01')
        # @_order_references ||= search.result
      end
    end
  end
end
