# frozen_string_literal: true

# :nodoc:
module Links
  def add_steps_link
    link_to 'Add Steps', routine_steps_path(routine)
  end

  def edit_routine_link
    link_to 'Edit Routine', edit_routine_path(routine)
  end

  def delete_link
    link_to 'Delete',
            routine,
            method: :delete,
            data: { confirm: "Are you sure you want to remove #{routine.title} from Routines?" }
  end
end
