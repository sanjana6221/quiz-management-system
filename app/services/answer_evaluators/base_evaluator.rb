module AnswerEvaluators
  # Base class for all answer evaluators
  # Defines the interface that all question type evaluators must implement
  class BaseEvaluator
    def initialize(question, attempt)
      @question = question
      @attempt = attempt
    end

    # Evaluates if the answer is correct for this question type
    # Returns a hash with evaluation result:
    # { correct: true/false }
    def evaluate
      raise NotImplementedError, "Subclasses must implement #evaluate"
    end

    protected

    attr_reader :question, :attempt

    # Helper method to parse selected option IDs from attempt
    def selected_option_ids
      ids = attempt&.selected_option_ids
      return [] if ids.blank?

      ids.is_a?(String) ? JSON.parse(ids) : Array.wrap(ids)
    end
  end
end
