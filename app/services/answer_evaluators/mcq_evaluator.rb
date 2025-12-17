module AnswerEvaluators
  # Evaluator for Multiple Choice Questions (MCQ)
  # A multiple choice question is correct if:
  # 1. All selected options are marked as correct
  # 2. All correct options are selected (no missing correct answers)
  class McqEvaluator < BaseEvaluator
    def evaluate
      option_ids = selected_option_ids
      return { correct: false } if option_ids.empty?

      # Get correct option IDs for this question
      correct_option_ids = question.options.where(correct: true).pluck(:id).to_set
      selected_ids_set = Set.new(option_ids)

      # Answer is correct only if:
      # 1. All selected options are correct
      # 2. All correct options are selected (complete match)
      { correct: selected_ids_set == correct_option_ids }
    end
  end
end
