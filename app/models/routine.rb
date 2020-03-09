# frozen_string_literal: true

# :nodoc:
class Routine < ApplicationRecord
  include ActsAsChainOfSteps

  belongs_to :user
  has_many :steps, dependent: :destroy
  has_many :routine_flows

  has_one_attached :avatar

  validates :avatar, attached: true
  validates_presence_of :title
end
