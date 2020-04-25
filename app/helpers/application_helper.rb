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

  def present(object)
    klass ||= "#{object.class}Presenter".constantize
    presenter = klass.new(object, self)

    if block_given?
      yield presenter
    else
      raise "calling present() without a block doesn't make sense!"
    end
  end
end
