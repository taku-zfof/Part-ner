class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  #diviseのログアウト後遷移先指定
  def after_sign_out_path_for(resource)
    new_user_session_path
  end
  #diviseのログイン後遷移先指定
  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

  #mmssage_broadcast_job.rbでrenderer.remderが使えない（原因不明）ため、代わりのメソッドを作成し使用する。
  def self.render_with_signed_in_user(user, *args)
    ActionController::Renderer::RACK_KEY_TRANSLATION['warden'] ||= 'warden'
    proxy = Warden::Proxy.new({}, Warden::Manager.new({})).tap{|i| i.set_user(user, scope: :user) }
    renderer = self.renderer.new('warden' => proxy)
    renderer.render(*args)
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :sex, :age, :prefecture, :introduction, :image, :account_name, :uid, :provider])
  end
end
