class Admin::UsersController < Admin::BaseController
  before_action :find_user, only: %i[make_admin delete_admin]

  def index; end

  def make_admin
    unless @user.update({ type: 'Admin' })
      flash.alert = @user.errors.full_messages
    end
    redirect_to admin_users_path
  end

  def delete_admin
    unless @user.update({ type: 'User' })
      flash.alert = @user.errors.full_messages
    end
    redirect_to admin_users_path
  end

  private

  def find_user
    @user = User.find(params[:id])
  end
end
