# frozen_string_literal: true

# :nodoc:
class Step < ApplicationRecord
  belongs_to :routine
  belongs_to :next, class_name: 'Step', foreign_key: 'next_id', optional: true

  validates_presence_of :title

  after_save  :maintain_linked_list_after_insertion!

  def to_linked_list
    raise 'Step is not first! Can not generate linked list' unless first

    result = [self]

    loop do
      current_step = result.last
      return result if current_step.next.blank?

      result << current_step.next
    end
  end

  def maintain_linked_list_after_insertion!
    if step_scope.one?
      self.update_column(:first, true)
      return
    end

    previous = step_scope.where.not(id: self.id).find_by(next_id: nil)

    previous.update_column(:next_id, self.id)
  end

  def maintain_linked_list_during_deletion!
    if first
      return if self.next.blank?

      self.next.update_column(:first, true)
    elsif self.next
      previous = step_scope.find_by(next: self)
      previous.update_column(:next_id, self.next_id)
    else
      previous = step_scope.find_by(next: self)
      previous.update_column(:next_id, nil)
    end
  end

  private

  def step_scope
    routine.steps
  end
end
