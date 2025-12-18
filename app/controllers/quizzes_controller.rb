class QuizzesController < ApplicationController
  # GET /quizzes
  def index
    @quizzes = Quiz.recent.with_questions_only
  end

  # GET /quizzes/:id
  def show
    @quiz = Quiz.with_questions_and_options.find(params[:id])
    @submission = Submission.new
  end
end
