# frozen_string_literal: true

RSpec.describe 'routine_flow_reports/index' do
  it 'displays a list of complete routine flows' do
    routine_flow1 = build_stubbed(:routine_flow, :complete, time_to_complete: 15.seconds)
    routine_flow2 = build_stubbed(:routine_flow, :complete, time_to_complete: 8.minutes + 33.seconds)
    routine_flow3 = build_stubbed(:routine_flow, :complete, time_to_complete: 2.hours + 17.minutes + 25.seconds)

    routine_flow_report_presenter = RoutineFlowReportPresenter.new(nil)

    assign(:routine_flows, [routine_flow1, routine_flow2, routine_flow3])
    assign(:presenter, routine_flow_report_presenter)

    render

    expect(rendered).to have_css('#complete-routine-flows *', count: 3)

    expect(rendered).to have_text("🏆 #3 | 📅 #{routine_flow1.completed_at.to_s(:long_ordinal)} | ⏱️ 2h 17m 25s")
    expect(rendered).to have_text("🏆 #2 | 📅 #{routine_flow1.completed_at.to_s(:long_ordinal)} | ⏱️ 0h 8m 33s")
    expect(rendered).to have_text("🏆 #1 | 📅 #{routine_flow1.completed_at.to_s(:long_ordinal)} | ⏱️ 15s")
  end
end
