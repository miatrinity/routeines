# frozen_string_literal: true

# :nodoc:
class StepsController < ApplicationController
  def index
    load_steps
  end

  def new
    load_routine
    @step = Step.new
  end

  def create
    build_step
    save_step('Step was successfully created.') or render :new
  end

  private

  def load_steps
    @steps ||= step_scope.to_a
  end

  def load_routine
    @routine ||= routine_scope.find(params[:routine_id])
  end

  def routine_scope
    current_user.routines
  end

  def build_step
    @step ||= step_scope.build
    @step.attributes = step_params
  end

  def step_scope
    load_routine
    @routine.steps
  end

  def save_step(notice)
    redirect_to(routine_steps_path(@routine), notice: notice) if @step.save
  end

  def step_params
    step_params = params[:step]
    step_params ? step_params.permit(:title) : {}
  end
end
