# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User visit finished routine flow', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'successfully' do
    routine = create(:routine, :with_steps)
    login_as routine.user
    visit root_path

    click_on 'Start Routine'
    routine.steps.count.times { click_on 'Finish Step' }

    routine_flow = routine.reload.routine_flows.last
    visit routine_routine_flow_path(routine, routine_flow)

    expect(page).to have_text(routine_flow.title)
    expect(page).to_not have_content(/flow steps? remaining/)
    expect(page).to_not have_css("progress")
    expect(page).to have_css('#completed-routine-flow img') # laurel-wreath.png

    expect(page).to_not have_xpath("//a[contains(.,'Finish Step')]")

    expect(page).to have_xpath("//a[contains(.,'Routines')]")
    expect(page).to have_xpath("//a[contains(.,'Reports')]")
  end
end
