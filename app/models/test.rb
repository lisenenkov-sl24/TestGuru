class Test < ApplicationRecord
  belongs_to :category
  has_many :questions, dependent: :destroy
  has_many :results, dependent: :destroy
  belongs_to :author, class_name: 'User'
  has_many :users, through: :results

  def self.names_by_category(category_name)
    Category.find_by(title: category_name)&.
      tests&.order(title: :desc)&.pluck(:title)
  end

end
