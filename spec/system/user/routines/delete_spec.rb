# frozen_string_literal: true

RSpec.describe 'User deletes routine' do
  it 'successfully', js: true do
    routine = create(:routine, :with_steps)

    login_as routine.user

    visit routines_path
    click_on 'Start Routine'
    visit routines_path

    accept_confirm do
      click_on 'Delete'
    end

    expect(page).to have_text('Routine was successfully deleted.')
    expect(page).to_not have_css('[id^=routine_]')
    expect(page).to have_css('#routine-count', text: '0')
  end
end
