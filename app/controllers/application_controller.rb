class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :about]
  before_action :configure_permitted_paramaters, if: :devise_controller?
  
  def after_sign_in_path_for(resource)
    user_path(current_user)
    

  end
  
  protected
  
  def configure_permitted_paramaters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  end
end
