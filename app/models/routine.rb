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
    return Routine.none if steps.empty?
    find_first_step.to_linked_list
  end

  private

  def find_first_step
    steps.find_by(first: true)
  end
end
