require 'spec_helper'

describe Category do
  it { should validate_presence_of :name }
  it { should validate_presence_of :acronym }
  it { should validate_presence_of :level }
  subject { FactoryGirl.create(:category) }
  it { should validate_uniqueness_of :name }
  it { should validate_uniqueness_of :acronym }
  it { should ensure_inclusion_of(:level).in_range(1..12) }
  it 'should be valid with all valid attributes' do
    subject.should be_valid
  end
end

# Associations
describe Category do
  it { should have_many(:documents).dependent(:destroy) }
end
