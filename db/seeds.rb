# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

categories = Category.create([{ title: 'Math' }, { title: 'Programming' }, { title: 'Language' }])

users = Admin.create!([
  { name: 'John', email: 'lisenenkovd@gmail.com', password: '123456' }
])

tests = Test.create!([
  { title: 'Arithmetic', level: 0, category: categories[0], author: users[0] },
  { title: 'Ruby', level: 1, category: categories[1], author: users[0] },
  { title: 'Russian', level: 2, category: categories[2], author: users[0] }
])

questions = Question.create!([
  { body: '2 + 2 = ', test: tests[0], answers: [Answer.new(text: '4', correct: true),  Answer.new(text: '5')] },
  { body: '4 + 2 = ', test: tests[0], answers: [Answer.new(text: '5'), Answer.new(text: '6', correct: true)] },
  { body: '8 + 2 = ', test: tests[0], answers: [Answer.new(text: '10', correct: true), Answer.new(text: '11')] }
])
