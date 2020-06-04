module SessionsHelper
  def show_messages
    if flash[:alert]
      content_tag :div, flash[:alert], class: 'alert alert-danger'
    elsif flash[:notice]
      content_tag :div, flash[:notice], class: 'alert alert-info'
    end
  end
end
