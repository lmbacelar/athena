require 'spec_helper'

describe 'PasswordResets' do
  it 'emails user when requesting password reset' do
    user = create(:user)
    visit root_path
    click_link 'password'
    fill_in 'email', with: user.email
    click_button 'Reset password'
    page.should have_content('Email sent')
    last_email.to.should include(user.email)
  end

  it 'does not email invalid user when requesting password reset' do
    visit root_path
    click_link 'password'
    fill_in 'email', :with => 'madeupuser@example.com'
    click_button 'Reset password'
    page.should have_content('Email sent')
    last_email.should be_nil
  end
end
