module AnswerEvaluators
  # Factory/Dispatcher for answer evaluators
  # Routes to the correct evaluator based on question type
  # To add a new question type:
  # 1. Create a new evaluator class (e.g., MyNewTypeEvaluator)
  # 2. Add it to the EVALUATORS hash below
  # That's it! No need to modify existing code.
  class Evaluator
    EVALUATORS = {
      'scq' => ScqEvaluator,
      'mcq' => McqEvaluator
    }.freeze

    def self.evaluate(question, attempt)
      evaluator_class = EVALUATORS[question.question_type]
      
      if evaluator_class.nil?
        raise "Unknown question type: #{question.question_type}"
      end
      
      evaluator_class.new(question, attempt).evaluate
    end

    # Returns all registered question types
    def self.supported_question_types
      EVALUATORS.keys
    end
  end
end
