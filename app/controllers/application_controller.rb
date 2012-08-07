class ApplicationController < ActionController::Base
  #protect_from_forgery
  # you can disable csrf protection on controller-by-controller basis:
  skip_before_filter :verify_authenticity_token
  
  
  def after_sign_in_path_for(resource_or_scope)
    if request.env['HTTP_REFERER'] =~ /admin/
      admin_dashboard_path
    else 
      '/users/index'
    end
  end
  
  def after_first_sign_in_path_for(resource_or_scope)
    '/users/edit' 
  end
  
  def after_update_path_for(resource_or_scope)
    if request.env['HTTP_REFERER'] =~ /admin/
      admin_dashboard_path
    else 
      '/users/index'
    end
  end
  
  protected
  unless Rails.application.config.consider_all_requests_local
    #rescue_from Exception, with: :render_500
    rescue_from ActionController::RoutingError, with: :render_404
    rescue_from ActionController::UnknownController, with: :render_404
    rescue_from ActionController::UnknownAction, with: :render_404
    #rescue_from ActiveRecord::RecordNotFound, with: :render_404
  end

  private

  def render_404(exception)
    @not_found_path = exception.message
    respond_to do |format|
      format.html { render template: 'errors/error_404', layout: 'layouts/application', status: 404 }
      format.all { render nothing: true, status: 404 }
    end
  end

  def render_500(exception)
    @error = exception
    respond_to do |format|
      format.html { render template: 'errors/error_500', layout: 'layouts/application', status: 500 }
      format.all { render nothing: true, status: 500}
    end
  end
end
