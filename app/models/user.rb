class User < ApplicationRecord
  has_many :created_tests, class_name: 'Test', foreign_key: 'author_id', dependent: :nullify
  has_many :results, dependent: :destroy
  has_many :processed_tests, class_name: 'Test', through: :results, source: 'user'

  def tests_by_level(level)
    processed_tests.
    where(level: level).
    distinct  
  end

end
