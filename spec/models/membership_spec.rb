require 'spec_helper'

describe Membership do
  context 'validations:' do
    let(:mbs) { create(:membership) }

    it { should validate_presence_of :user_id }
    it { should validate_presence_of :role_id }
    it { should validate_presence_of :group_id }

    specify '(user_id, role_id, group_id) should be unique' do
      build(:membership,  user_id:  mbs.user_id,
                          role_id:  mbs.role_id,
                          group_id: mbs.group_id).should_not be_valid
    end

    it 'should be valid with all valid attributes' do
      mbs.should be_valid
    end
  end

  context 'associations:' do
    it { should belong_to(:user) }
    it { should belong_to(:group) }
    it { should belong_to(:role) }
  end
end
