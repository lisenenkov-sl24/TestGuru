class Answer < ApplicationRecord
  belongs_to :question
  validates :text, presence: true
  validate :check_answers_count, on: :create

  scope :correct, -> { where correct: true }

  private

  def check_answers_count
    return unless question && question.answers.count > 3

    errors.add(:base, 'Answers count must be between 1 and 4')
  end
end
