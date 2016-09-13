module Api
  module V1
    module Trucking
      # Driver Commission History Api endpoint
      class DriverCommissionsHistoryController < Api::BaseController
        # NB: This action intentionally left blank.
        def index
          render :index, locals: { commissions: [] }
        end

        def by_paid_date
          commissions = DriverCommissionHistory
                        .where(PaidDate: params['paid_date'])

          render :index, locals: { commissions: commissions }
        end
      end
    end
  end
end
