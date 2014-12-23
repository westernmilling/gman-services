module Api
  module V1
    # Drivers Api endpoint
    class DriversController < ApplicationController
      # GET /drivers.json
      def index
        respond_to do |format|
          format.json { render :json => DriverAdapter.drivers }
        end
      end
    end
  end
end
