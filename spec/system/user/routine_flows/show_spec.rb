# frozen_string_literal: true

RSpec.describe 'User visit finished routine flow' do
  it 'successfully' do
    routine = create(:routine, :with_steps)
    login_as routine.user
    visit root_path

    click_on 'Start Routine'
    routine.steps.count.times { click_on 'Finish' }

    routine_flow = routine.reload.routine_flows.last
    visit routine_routine_flow_path(routine, routine_flow)

    expect(page).to have_text(routine_flow.title)
    expect(page).to_not have_content(/flow steps? remaining/)
    expect(page).to have_css('progress')
    expect(page).to have_css('#completed-routine-flow img') # laurel-wreath.png

    expect(page).to_not have_xpath("//a[contains(.,'Finish')]")

    expect(page).to have_xpath("//a[contains(.,'Routines')]")
    expect(page).to have_xpath("//a[contains(.,'Reports')]")
  end
end
