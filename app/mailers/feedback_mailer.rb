class FeedbackMailer < ApplicationMailer
  def feedback(feedback)
    @feedback = feedback
    mail from: @feedback.email, to: Admin.pluck(:email), subject: 'Feedback'
  end
end
