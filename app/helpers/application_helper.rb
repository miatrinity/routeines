# frozen_string_literal: true

# :nodoc:
module ApplicationHelper
  def avatar_name(record)
    if record.avatar.attached?
      record.avatar.filename
    else
      'No file chosen'
    end
  end
end
