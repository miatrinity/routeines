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
    click_on 'Finish'
    click_on 'Finish'
    click_on 'Finish'

    expect(page).to have_text("#{routine.title} was successfully finished.")
    expect(page).to have_text("finished at ")

  end
end
