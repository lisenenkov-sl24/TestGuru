class BadgeTry < Badge
  validates :parameter_number, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  def check?(result)
    result.user.results.where(test: result.test, passed: false).count < parameter_number
  end
end
