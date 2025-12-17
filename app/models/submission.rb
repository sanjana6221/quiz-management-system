class Submission < ApplicationRecord
  belongs_to :quiz
  has_many :attempt_answers, dependent: :destroy

  validates :total_questions, presence: true, numericality: { greater_than: 0 }
end
