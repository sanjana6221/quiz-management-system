module Admin
  class QuizzesController < ApplicationController
    before_action :require_admin_login
    before_action :set_quiz, only: [ :show, :destroy ]

    def index
      @quizzes = Quiz.includes(:questions).order(created_at: :desc)
    end

    def show
      @quiz = Quiz.includes(questions: :options).find(params[:id])
    end

    def new
      @quiz = Quiz.new
      @quiz.questions.build # Start with one question
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

    def destroy
      @quiz = Quiz.find(params[:id])
      @quiz.destroy
      redirect_to admin_quizzes_path, notice: "Quiz was successfully deleted."
    end

    private

    def set_quiz
      @quiz = Quiz.find(params[:id])
    end

    def quiz_params
      params.require(:quiz).permit(:title, :description,
        questions_attributes: [ :id, :body, :question_type, :_destroy,
          options_attributes: [ :id, :text, :correct, :_destroy ]
        ]
      )
    end

    def require_admin_login
      unless admin_signed_in?
        redirect_to admin_login_path, alert: "Please sign in as admin to access this page."
      end
    end
  end
end
