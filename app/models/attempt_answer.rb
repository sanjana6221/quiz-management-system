class AttemptAnswer < ApplicationRecord
  belongs_to :submission
  belongs_to :question
end
