# frozen_string_literal: true

module SystemTests
  def sign_in_as(email = 'someone@example.com', password = 'password')
    visit root_path

    click_on 'Log in'

    fill_in 'user[email]', with: email
    fill_in 'user[password]', with: password

    click_on 'Log in'
  end

  alias sign_in sign_in_as
end
