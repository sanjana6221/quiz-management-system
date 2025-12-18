module AnswerEvaluators
  class Evaluator
    EVALUATORS = {
      "scq" => ScqEvaluator,
      "mcq" => McqEvaluator
    }.freeze

    def self.evaluate(question, attempt)
      evaluator_class = EVALUATORS[question.question_type]

      if evaluator_class.nil?
        raise "Unknown question type: #{question.question_type}"
      end

      evaluator_class.new(question, attempt).evaluate
    end

    def self.supported_question_types
      EVALUATORS.keys
    end
  end
end
