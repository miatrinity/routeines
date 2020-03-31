# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User creates routine flow', type: :system do
  it 'successfully' do
    routine = create(:routine, :with_red_green_blue)
    login_as routine.user
    visit root_path

    click_on 'Start Routine'

    routine_flow = routine.reload.routine_flows.last

    expect(page).to have_text(routine.title)
    expect(page).to have_css('#current-flow-step-title', text: routine_flow.flow_steps.first.title)
    expect(page).to have_text("#{routine_flow.flow_steps.count} flow steps remaining!")
    expect(page).to have_css('div.upcoming-flow-step', count: (routine_flow.flow_steps.count - 1))
    expect(page).to have_css('div.upcoming-flow-step', text: routine_flow.flow_steps.second.title)
    expect(page).to have_css('div.upcoming-flow-step', text: routine_flow.flow_steps.third.title)
  end
end
