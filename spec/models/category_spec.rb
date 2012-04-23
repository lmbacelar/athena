require 'spec_helper'

describe Category do
  context 'validations:' do
    let(:cat) { create(:category) }

    it { should validate_presence_of :name }
    it { should validate_presence_of :acronym }
    it { should validate_presence_of :level }
    it { should ensure_inclusion_of(:level).in_range(1..12) }

    specify 'name should be unique' do
      cat; should validate_uniqueness_of :name
    end

    specify 'acronym should be unique' do
      cat; should validate_uniqueness_of :acronym
    end

    it 'should be valid with all valid attributes' do
      cat.should be_valid
    end
  end

  context 'associations:' do
    it { should have_many(:documents).dependent(:destroy) }
  end
end
