# frozen_string_literal: true

RSpec.describe 'User edits step' do
  it 'successfully' do
    routine = create(:routine, :with_steps)
    step = routine.steps.sample

    login_as routine.user

    visit routine_steps_path(routine)

    find("#step_#{step.id} [aria-label='edit']").click

    fill_in 'step[title]', with: "I'm an edited step"

    click_on 'Update Step'

    expect(page).to have_text('Step was successfully updated.')
    expect(page).to have_text("I'm an edited step")
  end
end
