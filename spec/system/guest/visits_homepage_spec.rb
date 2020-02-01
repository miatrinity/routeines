# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Guest visits homepage', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'successfully' do
    visit root_path

    expect(page).to have_text('You need to sign in or sign up before continuing.')
  end
end
