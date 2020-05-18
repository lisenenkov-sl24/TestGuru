module SessionsHelper
  def show_login_error
    content_tag :p, flash[:login_error], class: 'login_error' if flash[:login_error]
  end
end
