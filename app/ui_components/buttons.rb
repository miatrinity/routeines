module Buttons
  def reports_button
    link_to 'Reports',
            routine_routine_flow_reports_path(routine),
            class: 'button is-large is-info is-fullwidth'
  end

  def routines_button
    link_to 'Routines',
            routines_path,
            class: 'button is-large is-info is-fullwidth'
  end

  def finish_flow_step_button
    link_to 'Finish',
            finish_step_path,
            method: http_method,
            class: 'button is-large is-info is-fullwidth'
  end
end
