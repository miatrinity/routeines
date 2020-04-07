# frozen_string_literal: true

RSpec.describe 'User creates routine' do
  it 'successfully' do
    login_as create(:user)
    visit root_path

    click_on 'New'

    fill_in 'routine[title]', with: 'Evening routine'
    attach_file 'routine[avatar]', Rails.root.join('spec', 'fixtures', 'routine.png')

    click_on 'Create Routine'

    expect(page).to have_text('Routine was successfully created.')
    expect(page).to have_text('Evening routine')
    expect(page).to have_css('img[src*=routine]', count: 1)
    expect(page).to have_css('#routine-count', text: '1')
  end
end
