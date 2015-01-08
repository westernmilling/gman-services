module Api
  module V1
    module Trucking
      # Driver Commission History Api endpoint
      class DriverCommissionsHistoryController < ApplicationController
        before_action :doorkeeper_authorize!
        
        # GET /driver_commission_history.json
        def index
          respond_to do |format|
            format.json { render :json => DriverCommissionHistoryAdapter.all }
          end
        end

        # GET /driver_commission_history_by_paid_date.json
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
