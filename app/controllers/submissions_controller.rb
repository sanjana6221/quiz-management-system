class SubmissionsController < ApplicationController
  before_action :set_quiz, only: %i[create]
  before_action :set_submission, only: %i[show]

  def create
    @submission = @quiz.submissions.build(total_questions: @quiz.questions.count)

    if @submission.save
      process_answers
      redirect_to @submission, notice: "Quiz submitted successfully!"
    else
      render "quizzes/show", status: :unprocessable_entity
    end
  end

  def show
    @quiz = @submission.quiz
    @results = calculate_results
  end

  private

  def set_quiz
    @quiz = Quiz.with_questions_only.find(params[:quiz_id])
  end

  def set_submission
    @submission = Submission.with_attempt_answers.find(params[:id])
  end

  def process_answers
    Submissions::AnswerProcessor.new(@submission, params[:answers]).process
  end

  def calculate_results
    Submissions::ResultsCalculator.new(@submission).calculate
  end
end
