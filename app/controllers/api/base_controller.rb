module Api
  class BaseController < ApplicationController
    # before_action :doorkeeper_authorize!

    respond_to :json

    def render_json(results)
      render json: results
        .map(&:attributes)
        .map(&:to_snake_keys)
    end
  end
end
