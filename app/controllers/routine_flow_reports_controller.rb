# frozen_string_literal: true

# :nodoc:
class RoutineFlowReportsController < ApplicationController
  def index
    @routine = Routine.find(params[:id])
  end

  def show
    @routine = Routine.find(params[:id])
    @routine_flow = @routine.routine_flows.find(params[:id])
  end
end
