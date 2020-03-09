# frozen_string_literal: true

# :nodoc:
class Step < ApplicationRecord
  belongs_to :routine
  belongs_to :next, class_name: 'Step', foreign_key: 'next_id', optional: true

  validates_presence_of :title

  after_save :maintain_linked_list_after_insertion!
  before_destroy :maintain_linked_list_before_deletion!

  def to_linked_list
    return_empty_list_if_no_steps or build_linked_list_from([first_step])
  end

  private

  def return_empty_list_if_no_steps
    Step.none if first_step.blank?
  end

  def build_linked_list_from(steps)
    return_linked_list_of(steps) or build_linked_list_from(steps << next_step(steps))
  end

  def return_linked_list_of(steps)
    steps if next_step(steps).blank?
  end

  def next_step(steps)
    steps.last.next
  end

  def maintain_linked_list_after_insertion!
    set_first_step! or update_last_step_after_insertion!
  end

  def maintain_linked_list_before_deletion!
    ignore_single_step or
      update_first_of_multiple_steps! or
      update_middle_step! or
      update_last_step_before_deletion!
  end

  def first_step
    @_first_step ||= routine.steps.find_by(first: true)
  end

  def set_first_step!
    update_column(:first, true) if first_step_of_routine?
  end

  def first_step_of_routine?
    routine.steps.one?
  end

  def update_last_step_after_insertion!
    last_step_before_insertion.update_column(:next_id, id)
  end

  def last_step_before_insertion
    routine.steps.where.not(id: id).find_by(next_id: nil)
  end

  def ignore_single_step
    first && self.next.blank?
  end

  def update_first_of_multiple_steps!
    self.next.update_column(:first, true) if first
  end

  def previous
    routine.steps.find_by(next: self)
  end

  def update_middle_step!
    previous.update_column(:next_id, next_id) if self.next
  end

  def update_last_step_before_deletion!
    previous.update_column(:next_id, nil)
  end
end
