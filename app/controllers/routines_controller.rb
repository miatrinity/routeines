# frozen_string_literal: true

# :nodoc:
class RoutinesController < ApplicationController
  before_action :authenticate_user!

  def index
    load_routines
  end

  def new
    @routine = Routine.new
  end

  def create
    build_routine
    save_routine('Routine was successfully created.') or render :new
  end

  def edit
    load_routine
    build_routine
  end

  def update
    load_routine
    build_routine
    save_routine('Routine was successfully updated.') or render :edit
  end

=begin
  def destroy
    load_identity
    @identity.destroy

    redirect_to identities_path, notice: 'Identity was successfully deleted.'
  end
=end
  private

  def load_routines
    @routines ||= routine_scope.to_a
  end

  def load_routine
    @routine ||= routine_scope.find(params[:id])
  end

  def build_routine
    @routine ||= routine_scope.build
    @routine.attributes = routine_params
  end

  def save_routine(notice)
    redirect_to(routines_path, notice: notice) if @routine.save
  end

  def routine_scope
    current_user.routines
  end

  def routine_params
    routine_params = params[:routine]
    routine_params ? routine_params.permit(:title, :avatar) : {}
  end
end
