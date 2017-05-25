require 'timeout'

# rubocop:disable ColonMethodCall
module Api
  module V1
    class HealthCheckController < Api::BaseController
      def index
        result = Timeout::timeout(20) do
          Customer.count
        end

        if result
          render json: { health_check: 'Passed' }
        else
          render json: { health_check: 'Failed' }, status: 500
        end
      rescue ActiveRecord::JDBCError, ActiveRecord::ConnectionTimeoutError
        render json: { health_check: 'Failed' }, status: 500
      end
    end
  end
end
