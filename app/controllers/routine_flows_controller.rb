# frozen_string_literal: true

# :nodoc:
class RoutineFlowsController < ApplicationController
  before_action :authenticate_user!

  def create
    build_routine_flow
    save_routine_flow
    start_routine_flow
  end

  def show
    load_routine_flow
    redirect_to_report_if_completed or create_routine_flow_presenter
  end

  def update
    load_routine_flow
    take_next_routine_flow_step
  end

  def destroy
    load_routine_flow
    complete_routine_flow
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
    @routine_flow.save
  end

  def start_routine_flow
    @routine_flow.start!

    redirect_to routine_routine_flow_path(@routine, @routine_flow)
  end

  def take_next_routine_flow_step
    @routine_flow.take_next_flow_step!

    redirect_to routine_routine_flow_path(@routine, @routine_flow)
  end

  def complete_routine_flow
    @routine_flow.complete_routine_flow!

    redirect_to routine_flow_report_path(@routine, @routine_flow),
                notice: "#{@routine.title} was successfully finished."
  end

  def routine_flow_params
    routine_flow_params = params[:routine_flow]
    routine_flow_params ? routine_flow_params.permit : {}
  end

  def redirect_to_report_if_completed
    return unless @routine_flow.complete?

    redirect_to routine_flow_report_path(@routine, @routine_flow)
  end

  def create_routine_flow_presenter
    @presenter = RoutineFlowPresenter.new(@routine_flow)
  end
end
