# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User goes to next step in routine flow', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'successfully' do
    routine = create(:routine, :with_red_green_blue)
    login_as routine.user
    visit root_path

    click_on 'Start Routine'
    click_on 'Finish Step'

    routine_flow = routine.reload.routine_flows.last
    initial_step_count = routine_flow.flow_steps.count
    initial_upcoming_step_count = initial_step_count - 1

    expect(page).to_not have_css('#current-flow-step-title', text: 'Red Step')

    expect(page).to have_css('#current-flow-step-title', text: 'Green Step')

    expect(page).to have_text("#{initial_step_count - 1} flow steps remaining!")
    expect(page).to have_css('div.upcoming-flow-step', count: (initial_upcoming_step_count - 1))
    expect(page).to have_css('div.upcoming-flow-step', text: 'Blue Step')
  end
end
