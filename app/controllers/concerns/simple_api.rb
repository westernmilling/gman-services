module SimpleApi
  extend ActiveSupport::Concern

  def index
    render(
      :index,
      locals: { controller_name.to_sym => resources }
    )
  end

  protected

  def resource_name
    @_resource_name ||= controller_name.singularize
  end

  def search
    @_search ||= resource_class.ransack(params[:q])
  end

  def resources
    @_resources ||= search.result
  end

  def resource_class
    @_resource_class ||= resource_name.classify.constantize
  end
end
