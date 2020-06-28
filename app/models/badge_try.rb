class BadgeTry < Badge
  validates :parameter_number, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  def check?(result)
    parameter_number > user_results(result)
                       .where(results: { test: result.test, passed: false })
                       .count
  end
end
