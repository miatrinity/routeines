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

  # rubocop:disable Style/MethodMissingSuper:
  def method_missing(*args, &block)
    @template.send(*args, &block)
  end
  # rubocop:enable Style/MethodMissingSuper:

  def respond_to_missing?(*args, &block)
    super
  end
end
