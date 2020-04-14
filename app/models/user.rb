class User < ApplicationRecord
  has_many :results
  has_many :tests, through: :results
 

  def tests_by_level(level)
    tests.
    where(level: level).
    distinct  
  end

end
