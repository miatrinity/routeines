# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User signs out', type: :system do
  it 'successfully' do
    user = create(:user)

    sign_in user.email, user.password

    click_on 'Sign Out'

    expect(page).to have_text('Signed out successfully.')
  end
end
