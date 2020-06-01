# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # POST /resource/sign_in
  def create
    super
    flash[:notice] = t('devise.sessions.greeting', firstname: current_user.first_name, lastname: current_user.last_name)
  end
end
