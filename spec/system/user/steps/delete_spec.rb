# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User deletes step', type: :system do
  it 'successfully' do
    step = create(:step, first: true)

    login_as step.routine.user

    visit routine_steps_path(step.routine)

    accept_confirm do
      find("#step_#{step.id} [aria-label='delete']").click
    end

    expect(page).to have_text('Step was successfully deleted.')
    expect(page).to_not have_css('[id^=step_]')
    expect(page).to have_css('#step-count', text: '0')
  end
end
