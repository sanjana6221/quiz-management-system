module Submissions
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
      @multiple_choice_questions ||= quiz.questions.count
    end

    def correct_answers
      @correct_answers ||= calculate_correct_answers
    end

    def calculate_correct_answers
      submission.attempt_answers.count do |attempt|
        question = attempt.question
        next false unless question && attempt.selected_option_ids.present?

        result = AnswerEvaluators::Evaluator.evaluate(question, attempt)
        result[:correct]
      end
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
