class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  rescue_from CanCan::AccessDenied do |exception|

    redirect_to root_url, notice: "could not find with this id"
  end
  rescue_from ActiveRecord::RecordNotFound do |exception|
    redirect_to root_url, notice: "could not find with this id "
  end


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name , :role])
  end
end
