module AnswerEvaluators
  class ScqEvaluator < BaseEvaluator
    def evaluate
      option_ids = selected_option_ids
      return { correct: false } if option_ids.empty?

      selected_option = question.options.find { |opt| opt.id == option_ids.first }
      return { correct: false } unless selected_option&.correct?

      { correct: true }
    end
  end
end
