class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: [:email, :last_name, :first_name]
    devise_parameter_sanitizer.permit :account_update, keys: [:email, :last_name, :first_name]
  end

  def after_sign_in_path_for(resource)
    if current_user.is_a? Admin
      stored_location_for(resource) || admin_tests_path
    else
      super
    end
  end
end
