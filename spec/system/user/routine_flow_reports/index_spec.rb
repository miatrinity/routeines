# frozen_string_literal: true

RSpec.describe 'User visits routine flow reports page' do
  it 'successfully' do
    routine_flow = create(:routine_flow, :complete)
    login_as routine_flow.routine.user
    visit root_path

    click_on 'Reports'

    expect(page).to have_css('#complete-routine-flows div[id*=routine_flow_]', count: 1)
  end
end
