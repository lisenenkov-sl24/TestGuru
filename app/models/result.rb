class Result < ApplicationRecord
  belongs_to :test
  belongs_to :user
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :before_validation_update_status
  after_save :after_save_check_badges

  scope :uncompleted, -> { where.not(current_question_id: nil) }

  def accept!(answer_ids)
    if test.time_limit > 0 && test.time_limit.seconds.ago > created_at
      self.current_question_id = nil
      self.answers = test.questions.count
    else
      self.correct_answers += 1 if correct_answer?(answer_ids)
      self.answers += 1
    end
    save!
  end

  def completed?
    current_question_id.nil? && persisted?
  end

  private

  def before_validation_update_status
    return unless test.present?

    self.current_question_id =
      if persisted?
        test.questions.where('id > :id', id: current_question_id).minimum(:id)
      else
        test.questions.minimum(:id)
      end

    self.passed = current_question_id.nil? ? correct_answers >= 0.85 * answers : nil
  end

  def after_save_check_badges
    check_badges if saved_change_to_passed? && passed
  end

  def correct_answer?(answer_ids)
    current_question.answers.correct.ids.sort == answer_ids.sort
  end

  def check_badges
    Badge.all.each do |badge|
      UserBadge.create(user: user, badge: badge) if badge.check?(self)
    end
  end
end
