module ActsAsChainOfSteps
  extend ActiveSupport::Concern

  def to_chain_of_steps
    return_empty_chain_if_no_steps or build_chain_of_steps
  end

  private

  def return_empty_chain_if_no_steps
    Step.none if steps.empty?
  end

  def build_chain_of_steps
    steps.first.to_chain
  end
end