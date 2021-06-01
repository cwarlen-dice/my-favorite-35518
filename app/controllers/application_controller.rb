class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :basic_auth

  # # AdminUserに登録がなければ以下を登録
  # AdminUser.create!(email: 'admin@example.com', password: 'Password', password_confirmation: 'Password') if AdminUser.all.blank?
  if AdminUser.all.blank?
    AdminUser.create!(email: 'a@a', nickname: 'aaa', password: 'Password',
                      password_confirmation: 'Password')
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:allow_key])
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      # 環境変数により指定
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end
end
