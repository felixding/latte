class ApplicationController < ActionController::Base
  protect_from_forgery
  PER_PAGE = 10
  
  private
  
  def find_by_slug_or_404
    record_name = params[:controller].singularize
    model_name = record_name.titleize
    model_object = model_name.constantize
    record_object = model_object.find_by_slug(params[:id])

    unless record_object
      #redirect_to :status => 404
      render_error("404")
    end

    instance_variable_set("@#{record_name}", record_object)
  end
  
  def render_error(status)
    render :template => "static/#{status}"
  end
end
