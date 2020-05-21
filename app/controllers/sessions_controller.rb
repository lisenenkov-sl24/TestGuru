class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create]

  def new; end

  def create
    user = User.where('name = :name or email = :name', name: params[:name]).first

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to cookies.delete(:redirect_after_login) || tests_path
    else
      flash.now[:error] = 'Не найдены пользователь / пароль'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
