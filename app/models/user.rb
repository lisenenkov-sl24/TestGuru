class User < ApplicationRecord

def tests
  Test.
  joins('join questions on tests.id = questions.test_id').
  joins('join answers on questions.id = answers.question_id').
  where('answers.user_id = :user_id', user_id: id).
  distinct  
end

end
