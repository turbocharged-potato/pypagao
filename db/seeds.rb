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

nus = University.create(name: 'National University of Singapore',
                        domain: 'u.nus.edu')
smrt = University.create(name: 'SMRT', domain: 'smrt.sg')

tiffany = User.create(name: 'Tiffany',
                      password: '123456',
                      email: 'sciffany@gmail.com',
                      university: nus,
                      verified: true)
julius = User.create(name: 'Julius',
                     password: '123456',
                     email: 'test@test.com',
                     university: nus,
                     verified: true)
User.create(name: 'Jeffrey',
            password: 'han hock',
            email: 'jeffrey@smrt.sg',
            university: smrt)

cs1101s = Course.create(code: 'CS1101S', university: nus)
Course.create(code: 'MA1101R', university: nus)
Course.create(code: 'ABCDE', university: smrt)
semester = Semester.create(start_year: 2017,
                           end_year: 2018,
                           number: 1,
                           course: cs1101s)
paper = Paper.create(name: 'Finals', semester: semester)
question = Question.create(name: 'Essence of Recursion', paper: paper)
answer = Answer.create(content: 'make_fact',
                       imgur: 'www.google.com',
                       question: question,
                       user: tiffany)
Comment.create(content: 'y combinator', answer: answer, user: julius)
