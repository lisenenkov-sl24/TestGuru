class Question < ApplicationRecord
  belongs_to :test

  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers, reject_if: ->(attributes) { attributes['text'].blank? }

  validates :body, presence: true
  validate :check_answers_count

  private

  def check_answers_count
    return if (1..4).include? answers.size

    errors.add(:answers, 'count must be between 1 and 4')
  end
end
