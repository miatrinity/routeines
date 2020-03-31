# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User deletes step', type: :system do
  it 'successfully', js: true do
    routine = create(:routine, :with_steps)
    step = routine.reload.steps.sample

    login_as routine.user

    visit routine_steps_path(routine)

    accept_confirm do
      find("#step_#{step.id} [aria-label='delete']").click
    end

    expect(page).to have_text('Step was successfully deleted.')
    expect(page).to have_css('[id^=step_]', count: 2)
    expect(page).to have_css('#step-count', text: '2')
  end
end
