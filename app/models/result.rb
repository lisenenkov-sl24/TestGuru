class Result < ApplicationRecord
  belongs_to :test
  belongs_to :user
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :before_validation_set_current_question

  scope :uncompleted, -> { where.not(current_question_id: nil) }

  def accept!(answer_ids)
    self.correct_answers += 1 if correct_answer?(answer_ids)
    self.answers += 1
    save!
  end

  def completed?
    current_question_id.nil? && persisted?
  end

  def passed?
    completed? && correct_answers >= 0.85 * answers
  end

  private

  def before_validation_set_current_question
    return unless test.present?

    self.current_question_id =
      if persisted?
        test.questions.where('id > :id', id: current_question_id).minimum(:id)
      else
        test.questions.minimum(:id)
      end
  end

  def correct_answer?(answer_ids)
    current_question.answers.correct.ids.sort == answer_ids.sort
  end
end
