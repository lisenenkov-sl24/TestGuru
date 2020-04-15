class Test < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: 'User'
  has_many :questions, dependent: :destroy
  has_many :results, dependent: :destroy
  has_many :users, through: :results

  def self.names_by_category(category_name)
    joins(:category).
      where(categories: { title: category_name }).
      order('tests.title desc').
      pluck('tests.title')
  end

end
