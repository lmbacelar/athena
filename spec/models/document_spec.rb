require 'spec_helper'

describe Document do
  context 'validations:' do
    let(:doc) { create(:document) }

    it { should validate_presence_of :name }
    it { should validate_presence_of :title }
    it { should validate_presence_of :category_id }

    specify 'name should be unique' do
      doc; should validate_uniqueness_of(:name)
    end

    specify 'title should be unique' do
      doc; should validate_uniqueness_of(:title)
    end

    it 'should be valid with all valid attributes' do
      doc.should be_valid
    end
  end

  context 'associations:' do
    it { should have_many(:versions).dependent(:destroy) }
    it { should belong_to :category }
  end
end
