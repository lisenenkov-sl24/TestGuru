class User < ApplicationRecord

def tests
  Test.
  joins('join results on tests.id = results.test_id').
  where(results: { user_id: id }).
  distinct  
end

end
