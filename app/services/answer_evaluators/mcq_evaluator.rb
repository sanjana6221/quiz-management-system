module AnswerEvaluators
  class McqEvaluator < BaseEvaluator
    def evaluate
      option_ids = selected_option_ids
      return { correct: false } if option_ids.empty?

      correct_option_ids = question.options.where(correct: true).pluck(:id).to_set
      selected_ids_set = Set.new(option_ids)

      { correct: selected_ids_set == correct_option_ids }
    end
  end
end
