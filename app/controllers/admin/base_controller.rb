class Admin::BaseController < ApplicationController
  before_action :admin_required!

  layout 'admin'

  private

  def admin_required!
    redirect_to root_path, alert: t('errors.admin_required') unless current_user.is_a? Admin
  end
end
