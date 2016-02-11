module Api
  module V1
    module Trucking
      # Drivers Api endpoint
      class DriversController < ApplicationController
        before_action :doorkeeper_authorize!

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
