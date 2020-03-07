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

  def edit
    load_step
    build_step
  end

  def update
    load_step
    build_step
    save_step('Step was successfully updated.') or render :edit
  end

  def destroy
    set_up_destroy
    @step.destroy

    redirect_to routine_steps_path(@routine), notice: 'Step was successfully deleted.'
  end

  private

  def load_steps
    load_routine
    @steps ||= @routine.to_linked_list
  end

  def load_step
    @step ||= step_scope.find(params[:id])
  end

  def set_up_destroy
    load_step
    @step.maintain_linked_list_during_deletion!
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
    return unless @step.save

    redirect_to(routine_steps_path(@routine), notice: notice)
  end

  def step_params
    step_params = params[:step]
    step_params ? step_params.permit(:title) : {}
  end
end
