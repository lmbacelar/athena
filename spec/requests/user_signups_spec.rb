require 'spec_helper'

describe 'UserSignups' do
  let(:email) { 'user1@somedummyemail.net' }

  before do
    visit root_path
    click_link 'Sign Up'
    fill_in 'Email', with: email
    fill_in 'Name', with: 'User 1'
    fill_in 'Password', with: 'secret'
    fill_in 'confirmation', with: 'secret'
    click_button 'Create User'
  end

  it 'creates unactivated user when signing up' do
    user = User.find_by_email(email)
    user.should_not be_nil
    user.should_not be_active
  end

  it 'emails activation link after signup' do
    page.should have_content('Email sent')
    last_email.to.should include(email)
  end
end
