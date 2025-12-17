# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

AdminUser.find_or_create_by!(email: "admin@example.com") do |u|
  u.password = "password123"
  u.password_confirmation = "password123"
end

# Create sample quiz
quiz = Quiz.find_or_create_by!(title: "General Knowledge Quiz") do |q|
  q.description = "Test your general knowledge with these 5 questions"
end

if quiz.questions.count < 5
  quiz.questions.destroy_all

  # Question 1: Single Choice Question (scq)
  q1 = quiz.questions.create!(
    body: "What is the capital of France?",
    question_type: "scq"
  )
  q1.options.create!([
    { text: "London", correct: false },
    { text: "Paris", correct: true },
    { text: "Berlin", correct: false },
    { text: "Madrid", correct: false }
  ])

  # Question 2: Multiple Choice Question (mcq)
  q2 = quiz.questions.create!(
    body: "Which of the following are programming languages?",
    question_type: "mcq"
  )
  q2.options.create!([
    { text: "Ruby", correct: true },
    { text: "Python", correct: true },
    { text: "HTML", correct: false },
    { text: "JavaScript", correct: true }
  ])

  # Question 3: Single Choice Question (scq)
  q3 = quiz.questions.create!(
    body: "What is 2 + 2?",
    question_type: "scq"
  )
  q3.options.create!([
    { text: "3", correct: false },
    { text: "4", correct: true },
    { text: "5", correct: false },
    { text: "6", correct: false }
  ])

  # Question 4: Multiple Choice Question (mcq)
  q4 = quiz.questions.create!(
    body: "Which are primary colors?",
    question_type: "mcq"
  )
  q4.options.create!([
    { text: "Red", correct: true },
    { text: "Green", correct: false },
    { text: "Blue", correct: true },
    { text: "Yellow", correct: true }
  ])

  # Question 5: Single Choice Question (scq)
  q5 = quiz.questions.create!(
    body: "Which planet is closest to the Sun?",
    question_type: "scq"
  )
  q5.options.create!([
    { text: "Venus", correct: false },
    { text: "Earth", correct: false },
    { text: "Mercury", correct: true },
    { text: "Mars", correct: false }
  ])

  puts "Created quiz '#{quiz.title}' with #{quiz.questions.count} questions"
end
