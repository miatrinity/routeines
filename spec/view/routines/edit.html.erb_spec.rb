# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'routines/edit', type: :view do
  it 'avatar file-name is displayed if avatar is attached' do
    assign(:routine, create(:routine))
    render
    expect(rendered).to match(/routine.png/)
  end

  it 'displays breadcrumbs' do
    routine = create(:routine)
    assign(:routine, routine)
    render
    expect(rendered).to have_text(/Routines\s*Edit #{routine.title} Routine/m)
  end
end
