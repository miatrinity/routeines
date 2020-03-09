# frozen_string_literal: true

# :nodoc:
class Step < ApplicationRecord
  include Chainable

  belongs_to :routine
  belongs_to :next, class_name: 'Step', foreign_key: 'next_id', optional: true

  validates_presence_of :title
end
