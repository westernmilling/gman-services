module Api
  module V1
    module Trucking
      # Drivers Api endpoint
      class DriversController < ApplicationController
        before_action :doorkeeper_authorize!
        
        # GET /drivers.json
        def index
          respond_to do |format|
            format.json { render :json => DriverAdapter.all }
          end
        end
      end
    end
  end
end
