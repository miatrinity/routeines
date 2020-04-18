# frozen_string_literal: true

FactoryBot.define do
  factory :routine_flow do
    trait :complete do
      transient do
        overridden_time_to_complete { -1 }
      end

      before(:create) do |routine_flow, _|
        routine = create(:routine, :with_steps, steps_count: 1)
        routine.routine_flows << routine_flow
      end

      after(:create) do |routine_flow, evaluator|
        routine_flow_stepper = RoutineFlowStepper.new(routine_flow)
        routine_flow_stepper.start
        routine_flow_stepper.complete_routine_flow

        if evaluator.overridden_time_to_complete != -1
          routine_flow.update_attribute(:time_to_complete, evaluator.overridden_time_to_complete)
        end
      end
    end

    trait :with_0_out_of_3_completed_flow_steps do
      before(:create) do |routine_flow, _|
        @routine = create(:routine, :with_steps, steps_count: 3)
        @routine.routine_flows << routine_flow
      end

      after(:create) do |routine_flow, _|
        RoutineFlowStepper.new(routine_flow).start
      end
    end

    trait :with_1_out_of_3_completed_flow_steps do
      before(:create) do |routine_flow, _|
        @routine = create(:routine, :with_steps, steps_count: 3)
        @routine.routine_flows << routine_flow
      end

      after(:create) do |routine_flow, _|
        routine_flow_stepper = RoutineFlowStepper.new(routine_flow)
        routine_flow_stepper.start
        routine_flow_stepper.take_next_flow_step
      end
    end

    trait :with_2_out_of_3_completed_flow_steps do
      before(:create) do |routine_flow, _|
        @routine = create(:routine, :with_steps, steps_count: 3)
        @routine.routine_flows << routine_flow
      end

      after(:create) do |routine_flow, _|
        routine_flow_stepper = RoutineFlowStepper.new(routine_flow)
        routine_flow_stepper.start
        routine_flow_stepper.take_next_flow_step
        routine_flow_stepper.take_next_flow_step
      end
    end
  end
end
