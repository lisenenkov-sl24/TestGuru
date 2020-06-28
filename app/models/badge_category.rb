class BadgeCategory < Badge
  belongs_to :parameter_category, class_name: 'Category'

  def check?(result)
    return false unless result.test.category == parameter_category

    all_tests = Test.where(category: parameter_category).select(:id).order(:id)
    passed_tests = user_results(result)
                   .joins(:test)
                   .where(tests: { category: parameter_category }, results: { passed: true })
                   .distinct.select(:id).order(:id)
    all_tests == passed_tests
  end
end
