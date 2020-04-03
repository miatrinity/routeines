# frozen_string_literal: true

RSpec.describe 'User cancels routine creation' do
  it 'successfully' do
    login_as create(:user)
    visit new_routine_path

    click_on 'Cancel'

    expect(page).to have_current_path(routines_path)
  end
end
