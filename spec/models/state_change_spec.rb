require 'spec_helper'

describe StateChange do
  describe 'validations:' do
    it { should validate_presence_of :state }
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :version_id }
  end

  describe 'associations:' do
    it { should belong_to :version }
    it { should belong_to :user }
  end
end
