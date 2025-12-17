class Question < ApplicationRecord
  belongs_to :quiz, inverse_of: :questions
  has_many :options, dependent: :destroy, inverse_of: :question
  has_many :attempt_answers, dependent: :destroy

  enum :question_type, { mcq: 'mcq', scq: 'scq' }

  accepts_nested_attributes_for :options, allow_destroy: true, reject_if: :all_blank

  validates :body, presence: true
  validates :question_type, presence: true
end
