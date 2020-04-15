class RoutineFlowReportPresenter
  include ViewCompatibilityPack

  delegate :routine, to: :routine_flow, prefix: false

  def initialize(routine_flow)
    @routine_flow = routine_flow
    @routine_flow_presenter = RoutineFlowPresenter.new(routine_flow)
  end

  def reports_button
    link_to 'Reports',
            url_helpers.routine_routine_flow_reports_path(routine),
            class: 'button is-large is-info is-fullwidth'
  end

  def routines_button
    link_to 'Routines',
            url_helpers.routines_path,
            class: 'button is-large is-info is-fullwidth'
  end

  def completed_at
    formatted_date_time = routine_flow.completed_at.to_s(:long_ordinal)
    "completed on #{formatted_date_time}"
  end

  def time_to_complete
    binding.pry
    routine_flow.time_to_complete
  end

  private

  attr_reader :routine_flow
end
