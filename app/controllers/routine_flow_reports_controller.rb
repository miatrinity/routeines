# frozen_string_literal: true

# :nodoc:
class RoutineFlowReportsController < ApplicationController
  def index
    @routine = Routine.find(params[:id])
  end

  def show
    @routine = Routine.find(params[:routine_id])
    @routine_flow = @routine.routine_flows.find(params[:id])
    create_routine_flow_report_presenter
  end

  private

  def create_routine_flow_report_presenter
    @presenter = RoutineFlowReportPresenter.new(@routine_flow)
  end
end
