# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User creates step', type: :system do
  it 'successfully' do
    routine = create(:routine)
    login_as routine.user
    visit routine_steps_path(routine)

    click_on 'New'

    fill_in 'step[title]', with: 'Step 1'

    click_on 'Create Step'

    expect(page).to have_text('Step was successfully created.')
    expect(page).to have_text('Step 1')
    expect(page).to have_css('#step-count', text: '1')
  end
end
