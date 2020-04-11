# frozen_string_literal: true

RSpec.describe 'routine_flow_reports/show' do
  it 'displays the correct date and time when the routine was completed' do
    routine_flow = create(:routine_flow, :complete)
    routine_flow_report_presenter = RoutineFlowReportPresenter.new(routine_flow)

    assign(:routine_flow, routine_flow)
    assign(:presenter, routine_flow_report_presenter)

    render

    expect(rendered).to have_text("completed on #{routine_flow.completed_at.to_s(:long_ordinal)}")
  end
end
