require 'spec_helper'

describe Group do
  context 'validations:' do
    let(:grp) { create(:group) }

    it { should validate_presence_of :name }

    specify 'name should be unique' do
      grp; should validate_uniqueness_of(:name)
    end

    it 'should be valid with all valid attributes' do
      grp.should be_valid
    end
  end

  context 'associations:' do
    it { should have_many(:memberships).dependent(:destroy) }
    it { should have_many(:users).through(:memberships) }
    it { should have_many(:roles).through(:memberships) }
  end

  context 'scopes:' do
    specify 'should fetch groups with matching role, using with_role(:role)' do
      rol1 = create(:role); rol2 = create(:role)
      create(:membership, role: rol1)
      Group.with_role(rol1.name.to_sym).count.should be(1)
      create(:membership, role: rol1)
      Group.with_role(rol1.name.to_sym).count.should be(2)
      Group.with_role(rol2.name.to_sym).count.should be(0)
    end
  end
end
