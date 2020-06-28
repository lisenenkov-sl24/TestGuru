class User < ApplicationRecord
  has_many :created_tests, class_name: 'Test', foreign_key: 'author_id', dependent: :nullify
  has_many :results, dependent: :destroy
  has_many :processed_tests, class_name: 'Test', through: :results, source: 'user'
  has_many :gists, dependent: :destroy
  has_many :user_badges, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[a-zA-Z0-9]+\z/ }

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :trackable, :timeoutable

  def tests_by_level(level)
    processed_tests
      .where(level: level)
      .distinct
  end

  def to_s
    email
  end
end
