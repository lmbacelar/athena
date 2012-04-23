require 'spec_helper'

describe Role do
  context 'validations:' do
    let(:rol) { create(:role) }

    it { should validate_presence_of :name }

    specify 'name should be unique' do
      rol; should validate_uniqueness_of(:name)
    end

    it 'should be valid with all valid attributes' do
      rol.should be_valid
    end
  end

  context 'associations:' do
    it { should have_many(:memberships).dependent(:destroy) }
    it { should have_many(:users).through(:memberships) }
    it { should have_many(:groups).through(:memberships) }
  end

  context 'scopes:' do
    specify 'should fetch roles set to a group, using for_group(:group)' do
      grp1 = create(:group); grp2 = create(:group)
      create(:membership, group: grp1)
      Role.for_group(grp1.name.to_sym).count.should be(1)
      create(:membership, group: grp1)
      Role.for_group(grp1.name.to_sym).count.should be(2)
      Role.for_group(grp2.name.to_sym).count.should be(0)
    end
  end
end
