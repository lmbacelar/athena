require 'spec_helper'

describe User do
  context 'validations:' do
    let(:usr) { create(:user) }

    it { should validate_presence_of :email }

    specify 'email should be unique' do
      usr; should validate_uniqueness_of(:email)
    end

    it 'should be valid with all valid attributes' do
      usr.should be_valid
    end
  end

  context 'associations:' do
    it { should have_many(:memberships).dependent(:destroy) }
    it { should have_many(:groups).through(:memberships) }
    it { should have_many(:roles).through(:memberships) }
  end

  describe '#send_password_reset' do
    let(:user) { create(:user) }

    it 'generates a unique password_reset_token each time' do
      user.send_password_reset
      last_token = user.password_reset_token
      user.send_password_reset
      user.password_reset_token.should_not eq(last_token)
    end

    it 'saves the time the password reset was sent' do
      user.send_password_reset
      user.reload.password_reset_sent_at.should be_present
    end

    it 'delivers email to user' do
      user.send_password_reset
      last_email.to.should include (user.email)
    end
  end
end
