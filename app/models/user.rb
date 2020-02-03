# frozen_string_literal: true

# :nodoc:
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :routines
end
