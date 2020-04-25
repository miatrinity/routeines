# frozen_string_literal: true

# :nodoc:
class BasePresenter
  def initialize(object, template)
    @object = object
    @template = template
  end

  def self.presents(name)
    define_method(name) do
      @object
    end
  end

  private

  def method_missing(*args, &block)
    @template.send(*args, &block)
    super
  end

  def respond_to_missing?(*args, &block)
    super
  end
end
