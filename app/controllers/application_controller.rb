class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout :layout_by_resource

  before_action :configure_permitted_parameters, if: :devise_controller?

  def current_ability
    @current_ability ||= Ability.new current_admin if admin_signed_in?
    @current_ability ||= Ability.new current_user if user_signed_in?
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up){|u| u.permit(:name,
      :chatwork_id, :email, :password, :password_confirmation)}
    devise_parameter_sanitizer.permit(:account_update) {|u| u.permit(:name,
      :chatwork_id, :email, :password, :password_confirmation,
      :current_password)}
  end

  def layout_by_resource
    if (devise_controller? && resource_name == :admin) || admin_signed_in?
      "admin_application"
    elsif (devise_controller? && resource_name == :user) || user_signed_in?
      "user_application"
    else
      "application"
    end
  end
end
