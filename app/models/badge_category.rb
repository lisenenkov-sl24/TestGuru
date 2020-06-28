class BadgeCategory < Badge
  belongs_to :parameter_category, class_name: 'Category'

  def check?(result)
    return false unless result.test.category == parameter_category

    all_tests = Test.where(category: parameter_category).select(:id).sort
    passed_tests = result.user.processed_tests.where(category: parameter_category, results: { passed: true }).distinct.select(:id).sort
    all_tests == passed_tests
  end
end
