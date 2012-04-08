require 'spec_helper'

describe Document do
  let(:doc) { FactoryGirl.create(:document) }

  # Validations
  it { should validate_presence_of :name }
  it { should validate_presence_of :title }
  subject { FactoryGirl.create(:document) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_uniqueness_of(:title) }
  it 'should be valid with all valid attributes' do
    doc.should be_valid
  end
end
