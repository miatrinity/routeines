# frozen_string_literal: true

RSpec.describe 'Guest logs in' do
  it 'successfully' do
    user = create(:user)

    sign_in user.email, user.password

    expect(page).to have_text('Signed in successfully.')
    expect(page).to have_text(user.email)
  end
end
