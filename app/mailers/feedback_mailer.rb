class FeedbackMailer < ApplicationMailer
  def feedback(user, text)
    @user = user
    @text = text
    message = mail to: Admin.pluck(:email), subject: 'Feedback'
    message[:from] = user.email if user
    message
  end
end
