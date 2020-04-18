class Test < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: 'User'
  has_many :questions, dependent: :destroy
  has_many :results, dependent: :destroy
  has_many :users, through: :results
  validates :title, presence: true, uniqueness: { scope: :level }
  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :by_difficulty, -> (difficulty) do
    where( level: case difficulty
                  when :easy
                    0..1
                  when :medium
                    2..4
                  when :hard
                    5..Float::INFINITY
                  end )
  end 

  scope :names_by_category, -> (category_name) do
    joins(:category).
      where(categories: { title: category_name }).
      order('tests.title desc').
      pluck('tests.title')
  end

end
