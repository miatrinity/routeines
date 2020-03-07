# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User edits step', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'successfully' do
    step = create(:step, first: true)

    login_as step.routine.user

    visit routine_steps_path(step.routine)

    find("#step_#{step.id} [aria-label='edit']").click

    fill_in 'step[title]', with: "I'm an edited step"

    click_on 'Update Step'

    expect(page).to have_text('Step was successfully updated.')
    expect(page).to have_text("I'm an edited step")
  end
end
