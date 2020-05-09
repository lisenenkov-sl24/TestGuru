class Test < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: 'User'
  has_many :questions, dependent: :destroy
  has_many :results, dependent: :destroy
  has_many :users, through: :results
  validates :title, presence: true, uniqueness: { scope: :level }
  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :by_difficulty, (lambda do |difficulty|
    level = case difficulty
            when :easy
              0..1
            when :medium
              2..4
            when :hard
              5..Float::INFINITY
            end
    where(level: level)
  end)

  scope :by_category, (lambda do |category_name|
    joins(:category)
      .where(categories: { title: category_name })
      .order('tests.title desc')
  end)

  def difficulty
    case level
    when 0..1
      :easy
    when 2..4
      :medium
    when 5..Float::INFINITY
      :hard
    end
  end

  def self.names_by_category
    by_category.pluck('tests.title')
  end

  def to_s
    title
  end
end
