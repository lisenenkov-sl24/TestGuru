class BadgeDifficulty < Badge
  validates :parameter_string, inclusion: { in: %w[easy medium hard] }

  def check?(result)
    difficulty = parameter_string.to_sym

    return false unless result.test.difficulty == difficulty

    all_tests = Test.by_difficulty(difficulty).select(:id).sort
    passed_tests = result.user.processed_tests.by_difficulty(difficulty).where(results: { passed: true }).distinct.select(:id).sort
    all_tests == passed_tests
  end
end
