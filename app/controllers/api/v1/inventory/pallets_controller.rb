module Api
  module V1
    module Inventory
      class PalletsController < Api::BaseController
        def index
          render(:index, locals: { pallets: pallets })
        end

        def search
          @search ||= ::Inventory::Pallet.ransack(params[:q])
        end

        def pallets
          @pallets ||= search.result
        end
      end
    end
  end
end
