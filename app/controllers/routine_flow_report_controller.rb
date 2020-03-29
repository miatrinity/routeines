# frozen_string_literal: true

# :nodoc:
class RoutineFlowReportController < ApplicationController
  def index
    @routine = Routine.find(params[:id])
  end

  def show
    @routine = Routine.find(params[:id])
    @routine_flow = @routine.routine_flows.find(params[:routine_flow_id])
  end
end
