# frozen_string_literal: true

FactoryBot.define do
  factory :routine_flow do
    trait :with_0_out_of_3_completed_flow_steps do
      before(:create) do |routine_flow, _|
        @routine = create(:routine, :with_steps, steps_count: 3)
        @routine.routine_flows << routine_flow
      end

      after(:create) do |routine_flow, _|
        routine_flow.start!
      end
    end

    trait :with_1_out_of_3_completed_flow_steps do
      before(:create) do |routine_flow, _|
        @routine = create(:routine, :with_steps, steps_count: 3)
        @routine.routine_flows << routine_flow
      end

      after(:create) do |routine_flow, _|
        routine_flow.start!
        routine_flow.take_next_flow_step!
      end
    end

    trait :with_2_out_of_3_completed_flow_steps do
      before(:create) do |routine_flow, _|
        @routine = create(:routine, :with_steps, steps_count: 3)
        @routine.routine_flows << routine_flow
      end

      after(:create) do |routine_flow, _|
        routine_flow.start!
        routine_flow.take_next_flow_step!
        routine_flow.take_next_flow_step!
      end
    end
  end
end
