# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Step, type: :model do
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
      red_step, green_step, blue_step = create(:routine, :with_red_green_blue).steps

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
      red_step, green_step = create(:routine, :with_red_green).steps

      expect(red_step.first).to be_truthy
      expect(green_step.first).to be_falsy
      expect(red_step.next).to eql(green_step)
    end
  end

  describe '#maintain_linked_list_during_deletion!' do
    it 'when removing first step, its child is becoming the first step' do
      red_step, green_step = create(:routine, :with_red_green).steps

      red_step.destroy

      expect(green_step.reload.first).to be_truthy
    end

    it 'when removing middle step, next pointer is being maintained correctly' do
      red_step, green_step, blue_step = create(:routine, :with_red_green_blue).steps

      green_step.destroy

      expect(red_step.reload.first).to be_truthy
      expect(red_step.next).to eql(blue_step)
    end

    it 'when removing last step, remove next pointer from the new last step' do
      red_step, green_step = create(:routine, :with_red_green).steps

      green_step.destroy

      expect(red_step.reload.first).to be_truthy
      expect(red_step.next).to be_nil
    end
  end
end
