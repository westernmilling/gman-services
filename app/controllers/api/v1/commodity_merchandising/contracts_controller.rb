module Api
  module V1
    module CommodityMerchandising
      class ContractsController < Api::BaseController
        def index
          render(
            :index,
            locals: { contracts: contracts }
          )
        end

        def search
          @search ||= Contract.ransack(params[:q])
        end

        def contracts
          @contracts ||= search.result
        end
      end
    end
  end
end
