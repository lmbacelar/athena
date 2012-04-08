require 'spec_helper'

# Validations
describe Document do
  it { should validate_presence_of :name }
  it { should validate_presence_of :title }
  subject { FactoryGirl.create(:document) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_uniqueness_of(:title) }
  it 'should be valid with all valid attributes' do
    FactoryGirl.create(:document).should be_valid
  end
end

# Associations
describe Document do
  it { should have_many(:versions).dependent(:destroy) }

end
