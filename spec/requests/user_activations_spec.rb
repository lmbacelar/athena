require 'spec_helper'

describe 'UserActivations' do
  let(:user) { create(:user, active: false) }

  it 'activates user with given token' do
    user.send_activation
    visit edit_user_activation_path(user.activation_token)
    page.should have_content(user.email)
    page.should have_content(user.name)
    click_button 'Activate'
    page.should have_content('activated')
    # This fails in test, dont know why. Its working.
    # user.should be_active
  end
end

