# frozen_string_literal: true

FactoryBot.define do
  factory :routine do
    title { 'MyRoutine' }
    sequence(:user) { association(:user) }

    before(:create) do |routine|
      routine.avatar.attach(
        io: File.open(Rails.root.join('spec', 'fixtures', 'routine.png')),
        filename: 'routine.png', content_type: 'image/png'
      )
    end

    trait :with_steps do
      transient do
        steps_count { 3 }
      end

      after(:create) do |routine, evaluator|
        evaluator.steps_count.times do
          create(:step, routine: routine)
        end
      end
    end

    trait :with_red_green do
      after(:create) do |routine, _|
        red_step = create(:step, title: 'Red Step', routine: routine)
        create(:step, title: 'Green Step', routine: routine)
        red_step.reload
      end
    end

    trait :with_red_green_blue do
      after(:create) do |routine, _|
        red_step   = create(:step, title: 'Red Step', routine: routine)
        green_step = create(:step, title: 'Green Step', routine: routine)
        create(:step, title: 'Blue Step', routine: routine)
        red_step.reload
        green_step.reload
      end
    end
  end
end
