# frozen_string_literal: true

# :nodoc:
class Step < ApplicationRecord
  belongs_to :routine

  validates_presence_of :title
end
