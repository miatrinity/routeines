# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Guest logs in', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'successfully' do
    user = create(:user)

    sign_in user.email, user.password

    expect(page).to have_text('Signed in successfully.')
    expect(page).to have_text(user.email)
  end
end
