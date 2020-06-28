class Badge < ApplicationRecord
  has_many :user_badges, dependent: :destroy
  has_many :users, through: :user_badges
  validates :title, presence: true
  validates :image_name, presence: true

  def self.types
    %i[BadgeCategory BadgeDifficulty BadgeTry]
  end

  def check?(result); end
end
