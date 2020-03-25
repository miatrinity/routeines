# frozen_string_literal: true

# :nodoc:
class RoutineFlowsController < ApplicationController
  before_action :authenticate_user!

  def create
    build_routine_flow
    save_routine_flow
    @routine_flow.start!
  end

  def show
    load_routine_flow
  end

  def update
    load_routine_flow
    @routine_flow.next
    redirect_to(routine_routine_flow_path(@routine, @routine_flow))
  end

  private

  def build_routine_flow
    @routine_flow ||= routine_flow_scope.build
    @routine_flow.attributes = routine_flow_params
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

  def save_routine_flow
    redirect_to(routine_routine_flow_path(@routine, @routine_flow)) if @routine_flow.save
  end

  def routine_flow_params
    routine_flow_params = params[:routine_flow]
    routine_flow_params ? routine_flow_params.permit : {}
  end
end
