require 'spec_helper'

describe 'UserEdits' do

  let(:user) { create(:user) }

  # Create session
  before do
    visit login_path
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_button 'Login'
  end

  it 'displays edit page for user' do
    visit root_path
    click_link 'Edit User'
    new_name = 'User 2'
    fill_in 'Name', with: new_name
    click_button 'Update User'
  end
end
