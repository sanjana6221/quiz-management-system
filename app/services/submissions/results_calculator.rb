module Submissions
  # Service responsible for calculating and evaluating quiz results
  class ResultsCalculator
    PASS_THRESHOLD = 70.0

    def initialize(submission)
      @submission = submission
      @quiz = submission.quiz
    end

    def calculate
      {
        total_questions:,
        multiple_choice_questions:,
        correct_answers:,
        score_percentage:,
        passed:
      }
    end

    private

    attr_reader :submission, :quiz

    def total_questions
      @total_questions ||= quiz.questions.count
    end

    def multiple_choice_questions
      @multiple_choice_questions ||= quiz.questions.where(question_type: Question.question_types.keys).count
    end

    def correct_answers
      @correct_answers ||= calculate_correct_answers
    end

    def calculate_correct_answers
      quiz.questions.where(question_type: Question.question_types.keys).sum do |question|
        answer_correct_for_question?(question) ? 1 : 0
      end
    end

    def answer_correct_for_question?(question)
      attempt = submission.attempt_answers.find_by(question:)
      return false unless attempt&.selected_option_ids.present?

      # Delegate to the appropriate evaluator based on question type
      result = AnswerEvaluators::Evaluator.evaluate(question, attempt)
      result[:correct]
    end

    def score_percentage
      return 0 if multiple_choice_questions.zero?

      ((correct_answers.to_f / multiple_choice_questions) * 100).round(1)
    end

    def passed
      score_percentage >= PASS_THRESHOLD
    end
  end
end
