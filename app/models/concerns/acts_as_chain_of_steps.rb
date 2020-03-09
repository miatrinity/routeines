module ActsAsChainOfSteps
  extend ActiveSupport::Concern

  def to_linked_list
    return_empty_list_if_no_steps or build_linked_list_of_steps
  end

  private

  def return_empty_list_if_no_steps
    Step.none if steps.empty?
  end

  def build_linked_list_of_steps
    steps.first.to_chain
  end
end