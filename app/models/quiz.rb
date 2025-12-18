class Quiz < ApplicationRecord
  has_many :questions, dependent: :destroy, inverse_of: :quiz
  has_many :submissions, dependent: :destroy
  has_many :attempt_answers, through: :questions, source: :attempt_answers

  accepts_nested_attributes_for :questions, allow_destroy: true, reject_if: :all_blank

  validates :title, presence: true

  scope :recent, -> { order(created_at: :desc) }

  def self.with_questions_and_options
    includes(questions: :options).strict_loading
  end

  def self.with_questions_only
    includes(:questions).strict_loading
  end
end
