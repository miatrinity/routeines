# frozen_string_literal: true

RSpec.describe 'Guest visits homepage' do
  it 'successfully' do
    visit root_path

    expect(page).to have_text('You need to sign in or sign up before continuing.')
  end
end
