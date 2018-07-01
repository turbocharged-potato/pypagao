# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database
# with its default values.
# The data can then be loaded with the rails db:seed command (or created
# alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' },
#     { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

University.create(name: 'National University of Singapore', domain: 'u.nus.edu')
User.create(name: 'Tiffany', email: 'sciffany@gmail.com', university_id: 1)
Course.create(code: 'CS1101S', university_id: 1)
Course.create(code: 'MA1101R', university_id: 1)
Course.create(code: 'ABCDE', university_id: 2)
Semester.create(end_year: 2018, start_year: 2017, number: 1, course_id: 1)
Paper.create(name: 'Finals', semester_id: 1)
Question.create(name: 'Essence of Recursion', paper_id: 1)
Answer.create(content: 'make_fact', imgur: 'www.google.com', question_id: 1, user_id: 1)
Answer.create(content: 'make_fact(make_fact)', imgur: 'www.google.com', question_id: 1, user_id: 1)
