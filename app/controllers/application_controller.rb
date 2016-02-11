class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from(ActionController::UnknownFormat) do |e|
    logger.error(e.backtrace)
    request.format = :html
    head(:not_acceptable)
  end
end
