class Question < ApplicationRecord
  belongs_to :test

  has_many :answers, dependent: :destroy
  has_many :gists, dependent: :destroy

  accepts_nested_attributes_for :answers, reject_if: :reject_question, allow_destroy: true

  validates :body, presence: true
  validate :check_answers_count

  private

  def check_answers_count
    return if (1..4).include? answers.size

    errors.add(:answers, 'count must be between 1 and 4')
  end

  def reject_question(attributes)
    return false unless attributes['text'].blank?

    return true if attributes['id'].blank?

    attributes.merge!({ destroy: 1 })
    false
  end
end
