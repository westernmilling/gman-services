module Api
  module V1
    class HealthCheckController < Api::BaseController
      def index
        result = Customer.count

        if result
          render json: { health_check: 'Passed' }
        else
          render json: { health_check: 'Failed' }, status: 500
        end
      end
    end
  end
end
