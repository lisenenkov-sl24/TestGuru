class User < ApplicationRecord

def tests_by_level(level)
  Test.
  joins('join results on tests.id = results.test_id').
  where(results: { user_id: id }, tests: { level: level }).
  distinct  
end

end
