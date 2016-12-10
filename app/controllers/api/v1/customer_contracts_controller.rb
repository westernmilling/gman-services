module Api
  module V1
    class CustomerContractsController < Api::BaseController
      def index
        render :index, locals: { customer_contracts: customer_contracts }
      end

      protected

      def customer_contracts
        @_customer_contracs ||= CustomerContract
                                .joins(:contract)
                                .ransack(params[:q])
                                .result
      end
    end
  end
end
