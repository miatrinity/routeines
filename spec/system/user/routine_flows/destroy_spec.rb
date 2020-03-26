# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User finishes routine flow', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'successfully' do
    routine = create(:routine, :with_red_green_blue)
    login_as routine.user
    visit root_path

    click_on 'Start Routine'
    click_on 'Go to NEXT step'
    click_on 'Go to NEXT step'
    click_on 'Finish'

    expect(page).to have_text("You have finished #{routine.title}!")
  end
end
