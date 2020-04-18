# frozen_string_literal: true

RSpec.describe 'User finishes routine flow' do
  it 'successfully' do
    routine = create(:routine, :with_red_green_blue)
    login_as routine.user
    visit root_path

    click_on 'Start Routine'
    click_on 'Finish'
    click_on 'Finish'
    click_on 'Finish'

    expect(page).to have_text("#{routine.title} was successfully finished.")
    expect(page).to have_css('h1.title', text: routine.title)
    expect(page).to have_text('completed on ')
    expect(page).to have_css('progress')
    expect(page).to have_css('a.button', text: 'Reports')
    expect(page).to have_css('a.button', text: 'Routines')
  end
end
