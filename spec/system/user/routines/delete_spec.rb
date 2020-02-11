# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User deletes routine', type: :system do
  it 'successfully' do
    routine = create(:routine)

    login_as routine.user

    visit routines_path

    accept_confirm do
      click_on 'Delete'
    end

    expect(page).to have_text('Routine was successfully deleted.')
    expect(page).to_not have_css('[id^=routine_]')
    expect(page).to have_css('#routine-count', text: '0')
  end
end
