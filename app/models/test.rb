class Test < ApplicationRecord

def self.names_by_category(category_name)
  joins('join categories on tests.category_id = categories.id').
    where(categories: { title: category_name }).
    order('tests.title desc').
    pluck('tests.title')
end

end
