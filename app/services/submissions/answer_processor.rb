module Submissions
  # Service responsible for processing and storing user answers
  class AnswerProcessor
    def initialize(submission, answers_params)
      @submission = submission
      @answers_params = answers_params
    end

    def process
      return if answers_params.blank?

      # Batch load all questions to avoid N+1 queries
      questions_by_id = Question.where(id: answers_params.keys).index_by(&:id)

      answers_params.each do |question_id, answer_data|
        question = questions_by_id[question_id]
        process_answer(question, answer_data) if question
      end
    end

    private

    attr_reader :submission, :answers_params

    def process_answer(question, answer_data)
      return unless question.scq? || question.mcq?

      option_ids = extract_option_ids(answer_data)
      return if option_ids.blank?

      submission.attempt_answers.create!(
        question:,
        selected_option_ids: Array(option_ids)
      )
    end

    def extract_option_ids(answer_data)
      case answer_data
      when Array
        answer_data
      when String, Integer
        answer_data
      when Hash
        answer_data['option_id'] || answer_data['option_ids']
      else
        nil
      end
    end
  end
end
