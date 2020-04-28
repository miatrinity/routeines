# frozen_string_literal: true

# :nodoc:
class RoutinePresenter < BasePresenter
  include Buttons
  include Links

  presents :routine

  def start_routine_or_go_to_add_steps_button
    if routine.steps.any?
      start_routine_button
    else
      go_to_add_steps_when_routine_has_no_steps_button
    end
  end

  def secondary_links
    render partial: 'secondary_links', locals: { routine_presenter: self }
  end

  def add_steps_image_link
    link_to routine_steps_path(routine) do
      image_tag routine.avatar, id: "#{dom_id(routine)}-avatar"
    end
  end
end
