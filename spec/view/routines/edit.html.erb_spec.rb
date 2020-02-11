# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'routines/new', type: :view do
  it 'avatar file-name is displayed if avatar is attached' do
    assign(:routine, create(:routine))
    render
    expect(rendered).to match(/routine.png/)
  end
end
