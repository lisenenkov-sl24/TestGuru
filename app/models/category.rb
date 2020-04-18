class Category < ApplicationRecord
  has_many :tests, dependent: :restrict_with_exception
  validates :title, presence: true

  default_scope { order( title: :asc) }
end
