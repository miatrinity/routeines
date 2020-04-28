# frozen_string_literal: true

# :nodoc:
module Buttons
  def reports_button(extra_classes: '')
    link_to 'Reports',
            routine_routine_flow_reports_path(routine),
            id: "#{dom_id(routine)}-reports",
            class: "button is-large is-info is-fullwidth #{extra_classes}"
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

  def start_routine_button
    button_to 'Start Routine',
              routine_routine_flows_path(routine),
              start_routine_button_attributes
  end

  def go_to_add_steps_when_routine_has_no_steps_button
    link_to 'Start Routine',
            routine_steps_path(routine),
            start_routine_button_attributes
  end

  def start_routine_button_attributes
    {
      id: "#{dom_id(routine)}-start",
      class: 'button is-large is-fullwidth is-info',
      style: 'margin-bottom: 10px;'
    }
  end
end
