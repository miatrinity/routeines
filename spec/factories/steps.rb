# frozen_string_literal: true

FactoryBot.define do
  factory :step do
    title { 'Step 1' }
    sequence(:routine) { association(:routine) }
  end
end
