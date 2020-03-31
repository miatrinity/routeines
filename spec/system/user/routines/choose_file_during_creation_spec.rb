# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User chooses file when creating routine', type: :system do
  it 'filename shows up', js: true do
    login_as create(:user)

    visit new_routine_path

    attach_file 'routine[avatar]',
                Rails.root.join('spec', 'fixtures', 'routine.png'),
                make_visible: true

    expect(page).to have_css('#routine_avatar ~ .file-name', text: 'routine.png', count: 1)
  end
end
