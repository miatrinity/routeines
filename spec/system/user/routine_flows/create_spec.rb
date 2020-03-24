# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User creates routine flow', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'successfully' do
    routine = create(:routine, :with_red_green_blue)
    login_as routine.user
    visit root_path

    click_on 'Start Routine'

    routine_flow = routine.reload.routine_flows.last

    expect(page).to have_text(routine.title)
    expect(page).to have_css('#flow-item-current-title', text: routine_flow.flow_steps.first.title)
    expect(page).to have_text("#{routine_flow.flow_steps.count} flow steps")
    expect(page).to have_css('div.flow-step-upcomming', count: (routine_flow.flow_steps.count - 1))
    expect(page).to have_css('div.flow-step-upcomming', text: routine_flow.flow_steps.second.title)
    expect(page).to have_css('div.flow-step-upcomming', text: routine_flow.flow_steps.third.title)
  end
end
