# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Step, type: :model do
  def reload_steps!(*steps)
    steps.each { |step| step.reload }
  end

  describe '#title' do
    it { should validate_presence_of(:title) }
  end

  describe 'associations' do
    it { should belong_to(:routine) }
  end

  describe '#first' do
    it 'should return false by default' do
      expect(Step.new.first).to be_falsy
    end
  end

  describe '#to_linked_list' do
    it 'should return an array of steps in the desired order described by the linked list' do
      routine = create(:routine)
      red_step = create(:step, title: 'Red Step', routine: routine)
      green_step = create(:step, title: 'Green Step', routine: routine)
      blue_step = create(:step, title: 'Blue Step', routine: routine)

      reload_steps!(red_step, green_step)

      expect(red_step.to_linked_list.map{ |step| step.title }).to eql(['Red Step', 'Green Step', 'Blue Step'])
      expect(blue_step.next).to be_nil
      expect(green_step.first).to be_falsy
    end
  end

  describe '#maintain_linked_list_before_insertion!' do
    it '#first should be true when routine had no steps' do
      step = create(:step)

      expect(step.first).to be_truthy
    end

    it 'should set #next = self to the tail of the original list' do
      routine = create(:routine)
      red_step = create(:step, title: 'Red Step', routine: routine)
      green_step = create(:step, title: 'Green Step', routine: routine)

      expect(red_step.first).to be_truthy
      expect(green_step.first).to be_falsy
      expect(red_step.reload.next).to eql(green_step)
    end
  end

  describe '#maintain_linked_list_during_deletion!' do
    it 'no relevant attributes of a single step are updated' do
      lone_step = create(:step, title: 'Lone Step')

      first_before_deletion = lone_step.first
      next_before_deletion = lone_step.next

      lone_step.maintain_linked_list_during_deletion!

      first_during_deletion = lone_step.first
      next_during_deletion = lone_step.next

      expect(first_before_deletion).to eql(first_during_deletion)
      expect(next_before_deletion).to eql(next_during_deletion)
    end


    it 'when removing first step, its child is becoming the first step' do
      routine = create(:routine)

      red_step = create(:step, title: 'Red Step', routine: routine)
      green_step = create(:step, title: 'Green Step', routine: routine)

      red_step.reload.maintain_linked_list_during_deletion!

      expect(green_step.reload.first).to be_truthy
    end

    it 'when removing middle step, next pointer is being maintained correctly' do
      routine = create(:routine)
      red_step = create(:step, title: 'Red Step', routine: routine)
      green_step = create(:step, title: 'Green Step', routine: routine)
      blue_step = create(:step, title: 'Blue Step', routine: routine)

      reload_steps!(red_step, green_step)

      green_step.maintain_linked_list_during_deletion!

      red_step.reload

      expect(red_step.first).to be_truthy
      expect(red_step.next).to eql(blue_step)
    end

    it 'when removing last step, remove next pointer from the new last step' do
      routine = create(:routine)
      red_step = create(:step, title: 'Red Step', routine: routine)
      green_step = create(:step, title: 'Green Step', routine: routine)

      red_step.reload

      green_step.maintain_linked_list_during_deletion!

      red_step.reload

      expect(red_step.first).to be_truthy
      expect(red_step.next).to be_nil
    end
  end
end
