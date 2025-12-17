class Question < ApplicationRecord
  belongs_to :quiz
  has_many :options, dependent: :destroy
  has_many :attempt_answers, dependent: :destroy

  QUESTION_TYPES = %w[mcq scq].freeze

  validates :body, presence: true
  validates :question_type, presence: true, inclusion: { in: QUESTION_TYPES }
end
