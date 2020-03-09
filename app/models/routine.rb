# frozen_string_literal: true

# :nodoc:
class Routine < ApplicationRecord
  belongs_to :user
  has_many :steps, dependent: :destroy
  has_many :routine_flows

  has_one_attached :avatar

  validates :avatar, attached: true
  validates_presence_of :title

  def to_linked_list
    return_empty_list_if_no_steps or build_linked_list
  end

  private

  def return_empty_list_if_no_steps
    Step.none if steps.empty?
  end

  def build_linked_list
    steps.first.to_linked_list
  end
end
