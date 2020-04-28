# frozen_string_literal: true

RSpec.describe 'User starts empty routine flow' do
  it 'redirects to add steps page' do
    routine_flow = create(:routine_flow, :no_steps)
    login_as routine_flow.user
    visit root_path

    click_on 'Start Routine'

    have_current_path routine_steps_path(routine_flow.routine)

    expect(page).to have_text("Feed me some steps. I can't start an empty routine flow!")
  end
end
