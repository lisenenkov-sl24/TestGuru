class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def default_url_options
    { locale: I18n.locale == I18n.default_locale ? nil : I18n.locale }
  end

  protected

  def set_locale
    parsed_locale = params[:locale]
    I18n.locale = I18n.locale_available?(parsed_locale) ? parsed_locale : I18n.default_locale
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: %i[email last_name first_name]
    devise_parameter_sanitizer.permit :account_update, keys: %i[email last_name first_name]
  end

  def after_sign_in_path_for(resource)
    if current_user.is_a? Admin
      stored_location_for(resource) || admin_tests_path
    else
      super
    end
  end
end
