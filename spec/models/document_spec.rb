require 'spec_helper'

describe Document do
  let(:doc) { FactoryGirl.create(:document) }

  describe 'name validation' do
    it 'fails when empty' do
      FactoryGirl.build(:document, name: nil).should_not be_valid
    end

    it 'fails when duplicate' do
      FactoryGirl.build(:document, name: doc.name).should_not be_valid
    end

    it 'fails when too small' do
      char_count = (Document::NameLengthRange.first - 1)
      FactoryGirl.build(:document, name: "-" * char_count).should_not be_valid
    end

    it 'fails when too large' do
      char_count = (Document::NameLengthRange.last + 1)
      FactoryGirl.build(:document, name: "-" * char_count).should_not be_valid
    end
  end

  describe 'title validation' do
    it 'fails when empty' do
      FactoryGirl.build(:document, title: nil).should_not be_valid
    end
    it 'fails when duplicate' do
      FactoryGirl.build(:document, title: doc.title).should_not be_valid
    end
  end
end
