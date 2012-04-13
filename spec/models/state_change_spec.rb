require 'spec_helper'

describe StateChange do
  describe 'validations:' do
    it { should validate_presence_of :user }
    it { should validate_presence_of :state }
    it { should validate_presence_of :version }
  end

  describe 'associations:' do
    it { should belong_to :version }
  end
end
