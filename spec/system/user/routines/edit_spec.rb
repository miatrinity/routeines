# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User edits routine', type: :system do
  it 'successfully' do
    routine = create(:routine)

    login_as routine.user

    visit routines_path

    click_on 'Edit'

    fill_in 'routine[title]', with: "I'm an edited routine"
    attach_file 'routine[avatar]', Rails.root.join('spec', 'fixtures', 'edited_routine.png')

    click_on 'Update Routine'

    expect(page).to have_text('Routine was successfully updated.')
    expect(page).to have_text("I'm an edited routine")
    expect(page).to have_css('img[src*=edited_routine]', count: 1)
  end

  it 'Routine breadcrumb leads to routines index page' do
    routine = create(:routine)

    login_as routine.user

    visit edit_routine_path(routine)

    expect(page).to have_css("a[href='#{routines_path}']", count: 1, text: 'Routines')
  end
end
