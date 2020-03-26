# frozen_string_literal: true

# :nodoc:
class RoutineFlowReportController < ApplicationController
  def index
    @routine = Routine.find(params[:id])
  end
end
