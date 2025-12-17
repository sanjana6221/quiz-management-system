class AttemptAnswer < ApplicationRecord
  belongs_to :submission
  belongs_to :question
  belongs_to :selected_option, class_name: 'Option', optional: true
end
