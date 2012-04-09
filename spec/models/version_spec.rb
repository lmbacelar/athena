require 'spec_helper'

# Validations
describe Version do
  it { should validate_presence_of :number }
  it { should validate_presence_of :author }
  it { should validate_presence_of :authored_date }
  it { should validate_presence_of :document }
  subject { FactoryGirl.create(:version) }
  it { should validate_uniqueness_of(:number).scoped_to(:document_id) }
  it 'is invalid when author date is in the future' do
    subject.authored_date = 1.second.from_now
    subject.should_not be_valid
    subject.authored_date = Time.zone.now
    subject.should be_valid
  end

  its 'checked date should be equal or after its authored date' do
  end
  its 'approved date should be after its checked date' do
    pending 'Add this spec'
  end
  its 'withdrawn date should be after its authored date' do
    pending 'Add this spec'
  end

  its 'state should be draft when not checked' do
    pending 'Add this spec'
  end
  its 'state should be checked when not approved' do
    pending 'Add this spec'
  end
  its 'state should be approved when not withdrawn' do
    pending 'Add this spec'
  end
  its 'state should be withdrawn when withdrawn' do
    pending 'Add this spec'
  end
end

# Associations
describe Version do
  it {should belong_to :document }
end
