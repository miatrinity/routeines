# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Guest signs up', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'successfully' do
    visit root_path

    click_on 'Sign up'

    fill_in 'user[email]', with: 'jane.doe@example.com'
    fill_in 'user[password]', with: 'sikrit'
    fill_in 'user[password_confirmation]', with: 'sikrit'

    page.find('form#new_user input[value="Sign up"]').click

    expect(page).to have_text('You have signed up successfully.')
  end
end
