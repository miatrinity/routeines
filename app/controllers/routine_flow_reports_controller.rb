# frozen_string_literal: true

# :nodoc:
class RoutineFlowReportsController < ApplicationController
  def index
    load_routine_flows
  end

  def show
    load_routine_flow
    create_routine_flow_report_presenter
  end

  private

  def load_routine_flows
    @routine_flows ||= routine_flow_scope.order('completed_at desc').to_a
    @routine_flow_count = @routine_flows.size
  end

  def routine_flow_scope
    load_routine
    @routine.routine_flows
  end

  def load_routine_flow
    @routine_flow ||= routine_flow_scope.find(params[:id])
  end

  def load_routine
    @routine ||= routine_scope.find(params[:routine_id])
  end

  def routine_scope
    current_user.routines
  end

  def create_routine_flow_report_presenter
    @presenter = RoutineFlowReportPresenter.new(@routine_flow)
  end
end
