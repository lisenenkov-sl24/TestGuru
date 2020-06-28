class Badge < ApplicationRecord
  has_many :user_badges, dependent: :destroy
  has_many :users, through: :user_badges
  validates :title, presence: true
  validates :image_name, presence: true

  def self.types
    %i[BadgeCategory BadgeDifficulty BadgeTry]
  end

  def check?(result); end

  protected

  def user_results(result)
    user = result.user
    results = user.results
    previous_badge = user_badges.where(user: user).order(created_at: :desc).first
    results = results.where('created_at > :created_at', created_at: previous_badge.created_at) if previous_badge
    results
  end
end
