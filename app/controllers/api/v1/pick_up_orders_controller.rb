module Api
  module V1
    class PickUpOrdersController < Api::BaseController
      def index
        render(
          :index,
          locals: { pick_up_orders: pick_up_orders }
        )
      end

      protected

      def search
        @search ||= PickUpOrder.ransack(params[:q])
      end

      def pick_up_orders
        @pick_up_orders ||= search.result
      end
    end
  end
end
