# frozen_string_literal: true

# :nodoc:
class Step < ApplicationRecord
  belongs_to :routine
  belongs_to :next, class_name: 'Step', foreign_key: 'next_id', optional: true

  validates_presence_of :title

  after_save :maintain_linked_list_after_insertion!
  before_destroy :maintain_linked_list_before_deletion!

  def to_linked_list
    return Step.none if first_step.blank?

    result = [first_step]

    loop do
      current_step = result.last
      next_step = current_step.next

      return result if next_step.blank?

      result << next_step
    end
  end

  private

  def maintain_linked_list_after_insertion!
    set_first_step! or update_tail!
  end

  def maintain_linked_list_before_deletion!
    if first
      return if self.next.blank?

      self.next.update_column(:first, true)
    elsif self.next
      previous = routine.steps.find_by(next: self)
      previous.update_column(:next_id, self.next_id)
    else
      previous = routine.steps.find_by(next: self)
      previous.update_column(:next_id, nil)
    end
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

  def update_tail!
    tail_before_insertion.update_column(:next_id, id)
  end

  def tail_before_insertion
    routine.steps.where.not(id: id).find_by(next_id: nil)
  end
end
