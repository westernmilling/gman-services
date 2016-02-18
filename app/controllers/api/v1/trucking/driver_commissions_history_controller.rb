module Api
  module V1
    module Trucking
      # Driver Commission History Api endpoint
      class DriverCommissionsHistoryController < Api::BaseController
        def index
          respond_to do |format|
            format.json { render json: DriverCommissionHistoryAdapter.all }
          end
        end

        def by_paid_date
          respond_to do |format|
            format.json do
              render json: DriverCommissionHistoryAdapter
                .by_paid_date(params['paid_date'])
            end
          end
        end
      end
    end
  end
end
