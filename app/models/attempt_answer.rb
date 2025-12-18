class AttemptAnswer < ApplicationRecord
  belongs_to :submission, inverse_of: :attempt_answers
  belongs_to :question

  def selected_option_ids
    return [] if self[:selected_option_ids].blank?

    json_data = self[:selected_option_ids]
    parsed = json_data.is_a?(String) ? JSON.parse(json_data) : json_data
    Array(parsed).map { |id| id.is_a?(Integer) ? id : id.to_i }
  end

  def selected_option_ids=(ids)
    self[:selected_option_ids] = JSON.dump(Array(ids).map(&:to_i))
  end

  def selected_options
    return [] if selected_option_ids.blank?

    if question.options.loaded?
      question.options.select { |opt| selected_option_ids.include?(opt.id) }
    else
      question.options.where(id: selected_option_ids)
    end
  end
end
