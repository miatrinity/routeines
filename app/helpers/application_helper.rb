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
    raise "calling present() without a block doesn't make sense!" unless block_given?

    klass ||= "#{object.class}Presenter".constantize
    presenter = klass.new(object, self)

    yield presenter
  end
end
