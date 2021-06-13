class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :basic_auth

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[nickname])
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      # 環境変数により指定
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end

  # ログイン時に機能する
  def after_sign_in_path_for(resource)
    user_path(resource.id) # ログイン後に遷移するpathを設定
  end

  def index?
    action_name == 'index'
  end

  def show?
    action_name == 'show'
  end

  helper_method :index?, :show?
end
