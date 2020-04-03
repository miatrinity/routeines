# frozen_string_literal: true

RSpec.describe 'routines/new', type: :view do
  it "'No file chosen' is displayed if no avatar is attached" do
    assign(:routine, Routine.new)
    render
    expect(rendered).to match(/No file chosen/)
  end
end
