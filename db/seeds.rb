# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

categories = Category.create([{ title: 'Math' }, { title: 'Programming' }, { title: 'Language' }])

users = User.create([{ name: 'John' }, { name: 'Dick' }, { name: 'Mary' }])

tests = Test.create([
  { title: 'Arithmetic', level: 0, category_id: categories[0].id },
  { title: 'Ruby', level: 1, category_id: categories[1].id },
  { title: 'Russian', level: 2, category_id: categories[2].id }
])

questions = Question.create([
  { body: '2 + 2 = ', test_id: tests[0].id },
  { body: '4 + 2 = ', test_id: tests[0].id },
  { body: '8 + 2 = ', test_id: tests[0].id }
])

answers = Answer.create([
  { question_id: questions[0].id, user_id: users[1].id, correct: true },
  { question_id: questions[1].id, user_id: users[1].id }
])
