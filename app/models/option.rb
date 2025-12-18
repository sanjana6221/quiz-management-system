class Option < ApplicationRecord
  belongs_to :question, inverse_of: :options

  validates :text, presence: true

  # Scopes for common queries
  scope :correct_answers, -> { where(correct: true) }
  scope :incorrect_answers, -> { where(correct: false) }
end
