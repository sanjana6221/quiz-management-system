module AnswerEvaluators
  class BaseEvaluator
    def initialize(question, attempt)
      @question = question
      @attempt = attempt
    end

    def evaluate
      raise NotImplementedError, "Subclasses must implement #evaluate"
    end

    protected

    attr_reader :question, :attempt

    def selected_option_ids
      attempt&.selected_option_ids || []
    end
  end
end
