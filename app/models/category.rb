class Category < ApplicationRecord
  default_scope { order(title: :asc) }

  has_many :tests, dependent: :restrict_with_exception
  validates :title, presence: true

  def to_s
    title
  end
end
