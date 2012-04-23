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
end
