class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  # helper_method :current_user

  # private


  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[nickname birthday])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[nickname birthday])
  end
  # def current_user
  #   @current_user ||= User.where(id: cookies.signed[:user_id]).first

  #   if @current_user.nil?
  #     @current_user = User.create
  #     cookies.signed[:user_id] = current_user.id
  #   end

  #   @current_user
  # end
end
