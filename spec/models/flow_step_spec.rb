# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FlowStep, type: :model do
  describe 'newly created flow step' do
    it 'has status of :upcoming' do
      flow_step = FlowStep.new

      expect(flow_step).to be_upcoming
    end

    it 'has duration of 0' do
      flow_step = FlowStep.new

      expect(flow_step.time_to_complete).to eql('0')
    end
  end

  describe 'associations' do
    it { should belong_to(:routine_flow) }
    it { should belong_to(:step) }
  end
end
