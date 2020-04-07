# frozen_string_literal: true

RSpec.describe 'User signs out' do
  it 'successfully' do
    user = create(:user)

    sign_in user.email, user.password

    click_on 'Sign Out'

    expect(page).to have_text('Signed out successfully.')
  end
end
