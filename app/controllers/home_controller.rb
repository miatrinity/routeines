# frozen_string_literal: true

# :nodoc:
class HomeController < ApplicationController
  before_action :authenticate_user!

  def index; end
end
