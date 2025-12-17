class QuizzesController < ApplicationController
  def index
    @quizzes = Quiz.includes(:questions).order(created_at: :desc)
  end

  def show
    @quiz = Quiz.includes(questions: :options).find(params[:id])
    @submission = Submission.new
  end
end
