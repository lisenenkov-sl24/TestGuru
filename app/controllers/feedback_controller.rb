class FeedbackController < ApplicationController
  skip_before_action :authenticate_user!

  def new; end

  def create
    if params[:message].blank?
      puts "ddd #{params[:return]}"
      redirect_to new_feedback_path(return: params[:return]), alert: t('.message_blank_error')
      return
    end

    FeedbackMailer.feedback(current_user, params[:message]).deliver_now

    redirect_url = params[:return].blank? ? root_path : params[:return];
    redirect_to redirect_url, alert: t('.message_sent')
  end
end
