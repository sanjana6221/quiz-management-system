class Submission < ApplicationRecord
  belongs_to :quiz, inverse_of: :submissions
  has_many :attempt_answers, dependent: :destroy, inverse_of: :submission

  validates :total_questions, presence: true, numericality: { greater_than: 0 }

  def self.with_attempt_answers
    includes(:quiz, quiz: { questions: :options }, attempt_answers: { question: :options }).strict_loading
  end

  scope :recent, -> { order(created_at: :desc) }

  def attempt_answers_by_question_id
    @attempt_answers_by_question_id ||= attempt_answers.index_by(&:question_id)
  end

  def find_attempt_answer(question)
    attempt_answers_by_question_id[question.id]
  end
end
