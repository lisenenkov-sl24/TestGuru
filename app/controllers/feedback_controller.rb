class FeedbackController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(feedback_params)
    if current_user
      @feedback.name = current_user.name
      @feedback.email = current_user.email
    else
      @feedback.name = 'Unknown user'
    end
    unless @feedback.valid?
      render :new
      return
    end

    FeedbackMailer.feedback(@feedback).deliver_now

    redirect_url = params[:return].blank? ? root_path : params[:return];
    redirect_to redirect_url, alert: t('.message_sent')
  end

  private

  def feedback_params
    params.require(:feedback).permit(:email, :message)
  end
end
