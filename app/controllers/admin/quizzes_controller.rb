module Admin
  class QuizzesController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_quiz, only: %i[show edit update destroy]

    def index
      @quizzes = Quiz.recent.with_questions_only
    end

    def show
    end

    def new
      @quiz = Quiz.new
      @quiz.questions.build
    end

    def create
      @quiz = Quiz.new(quiz_params)

      if @quiz.save
        redirect_to admin_quiz_path(@quiz), notice: "Quiz was successfully created."
      else
        @quiz.questions.build if @quiz.questions.empty?
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @quiz.update(quiz_params)
        redirect_to admin_quiz_path(@quiz), notice: "Quiz was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @quiz.destroy
      redirect_to admin_quizzes_path, notice: "Quiz was successfully deleted."
    end

    private

    def set_quiz
      scope = %w[show edit].include?(action_name) ? Quiz.with_questions_and_options : Quiz
      @quiz = scope.find(params[:id])
    end

    def quiz_params
      params.require(:quiz).permit(
        :title, :description,
        questions_attributes: [
          :id, :body, :question_type, :_destroy,
          { options_attributes: %i[id text correct _destroy] }
        ]
      )
    end
  end
end
