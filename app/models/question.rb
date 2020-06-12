class Question < ApplicationRecord
  belongs_to :test

  has_many :answers, dependent: :destroy
  has_many :gists, dependent: :destroy
  
  accepts_nested_attributes_for :answers, reject_if: :reject_qiestion, allow_destroy: true

  validates :body, presence: true
  validate :check_answers_count

  private

  def check_answers_count
    return if (1..4).include? answers.size

    errors.add(:answers, 'count must be between 1 and 4')
  end

  def reject_qiestion(attributes)
    return false unless attributes['text'].blank?

    return true if attributes['id'].blank?

    attributes.merge!({:_destroy => 1})
    false
  end
end
