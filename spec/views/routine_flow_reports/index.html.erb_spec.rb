# frozen_string_literal: true

RSpec.describe 'routine_flow_reports/index' do
  it 'displays a list of complete routine flows' do
    routine_flow1 = create(:routine_flow, :complete, overridden_time_to_complete: 15.seconds)
    routine_flow2 = create(:routine_flow, :complete, overridden_time_to_complete: 8.minutes + 33.seconds)
    routine_flow3 = create(:routine_flow, :complete, overridden_time_to_complete: 2.hours + 17.minutes + 25.seconds)

    assign(:routine, routine_flow1.routine)
    assign(:routine_flows, [routine_flow1, routine_flow2, routine_flow3])
    assign(:routine_flow_count, 3)

    render

    squished_page_text = (strip_tags rendered).squish

    expect(rendered).to have_css('#complete-routine-flows div[id*=routine_flow_]', count: 3)

    expect(squished_page_text).to have_text("🏆 #3 📅 #{routine_flow1.completed_at.to_s(:long_ordinal)} ⏱️ 0h 0m 15s")
    expect(squished_page_text).to have_text("🏆 #2 📅 #{routine_flow2.completed_at.to_s(:long_ordinal)} ⏱️ 0h 8m 33s")
    expect(squished_page_text).to have_text("🏆 #1 📅 #{routine_flow3.completed_at.to_s(:long_ordinal)} ⏱️ 2h 17m 25s")
  end
end
