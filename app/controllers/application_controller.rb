class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  #diviseのログアウト後遷移先指定
  def after_sign_out_path_for(resource)
    new_user_session_path
  end
  #diviseのログイン後遷移先指定
  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :sex, :age, :prefecture, :introduction, :image])
  end
end
