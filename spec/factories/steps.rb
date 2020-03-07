# frozen_string_literal: true

FactoryBot.define do
  factory :step do
    sequence(:title) { |n| "Step #{n}" }
    sequence(:routine) { association(:routine) }
  end
end
