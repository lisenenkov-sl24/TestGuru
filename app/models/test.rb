class Test < ApplicationRecord

def self.names_by_category(category_name)
  Test.
  joins('join categories on tests.category_id = categories.id').
  where('categories.title LIKE :category_name', category_name: category_name).
  order('tests.title desc').
  pluck('tests.title')
end

end
