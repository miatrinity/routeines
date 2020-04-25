# frozen_string_literal: true

RSpec.describe 'routine_flows/show' do
  it 'displays the correct progress when no flow steps are complete' do
    verify_routine_flow_progress :with_0_out_of_3_completed_flow_steps, complete: 0
  end

  it 'displays the correct progress when 1 (out of 3) flow step is complete' do
    verify_routine_flow_progress :with_1_out_of_3_completed_flow_steps, complete: 1
  end

  it 'displays the correct progress when 2 (out of 3) flow step is complete' do
    verify_routine_flow_progress :with_2_out_of_3_completed_flow_steps, complete: 2
  end

  private

  def verify_routine_flow_progress(m_out_of_n_steps_completed, complete:)
    routine_flow = create(:routine_flow, m_out_of_n_steps_completed)
    assign(:routine_flow, routine_flow)
    assign(:presenter, RoutineFlowPresenter.new(routine_flow, view))

    render

    completion_rate = (complete / Float(3) * 100).floor
    expect(rendered).to have_css("progress[value='#{completion_rate}']")
  end
end
