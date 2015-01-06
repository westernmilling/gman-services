module Api
  module V1
    module Trucking
      # Drivers Api endpoint
      class DriverCommissionsHistoryController < ApplicationController
        # GET /driver_commission_history.json
        def index
          respond_to do |format|
            format.json { render :json => DriverCommissionHistoryAdapter.all }
          end
        end

        # GET /driver_commission_history#by_paid_date
        def by_paid_date
          respond_to do |format|
            format.json do
              render :json => DriverCommissionHistoryAdapter
                .by_paid_date(params['paid_date'])
            end
          end
        end
      end
    end
  end
end
