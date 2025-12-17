module AnswerEvaluators
  # Evaluator for Single Choice Questions (SCQ)
  # A single choice question is correct if the selected option is marked as correct
  class ScqEvaluator < BaseEvaluator
    def evaluate
      option_ids = selected_option_ids
      return { correct: false } if option_ids.empty?

      selected_option = Option.find_by(id: option_ids.first)
      return { correct: false } unless selected_option&.correct?

      { correct: true }
    end
  end
end
