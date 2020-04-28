# frozen_string_literal: true

RSpec.describe 'User routine avatar' do
  it 'goes to steps index for the given routine' do
    routine = create(:routine)

    login_as routine.user

    visit routines_path

    click_on_avatar(routine)

    expect(page).to have_text "#{routine.title} - Steps"
    expect(page).to have_current_path routine_steps_path(routine)
  end

  private

  def click_on_avatar(routine)
    find(:xpath, "//a[child::img[@id='routine_#{routine.id}-avatar']]").click
  end
end
