require 'spec_helper'

# Validations
describe Version do
  it { should validate_presence_of :number }
  it { should validate_presence_of :author }
  it { should validate_presence_of :authored_date }
  subject { FactoryGirl.create(:version) }
  it { should validate_uniqueness_of(:number).scoped_to(:document_id) }
  it 'is invalid when author date is in the future' do
    subject.authored_date = 1.second.from_now
    subject.should_not be_valid
    subject.authored_date = Time.zone.now
    subject.should be_valid
  end
end

# Associations
describe Version do
  it {should belong_to :document }
end
