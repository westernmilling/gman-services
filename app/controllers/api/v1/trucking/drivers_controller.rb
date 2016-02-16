module Api
  module V1
    module Trucking
      # Drivers Api endpoint
      class DriversController < Api::BaseController
        def index
          respond_to do |format|
            format.json do
              render json: DriverAdapter.all
            end
          end
        end
      end
    end
  end
end
