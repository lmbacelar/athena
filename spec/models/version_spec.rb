require 'spec_helper'

describe Version do
#   context 'validations:' do
#
#     let(:ver) { create(:version) }
#
#     it { should validate_presence_of :number }
#     it { should validate_presence_of :author }
#     it { should validate_presence_of :authored_date }
#     it { should validate_presence_of :document }
#
#     specify 'number should be unique on each document' do
#       ver.should validate_uniqueness_of(:number).scoped_to(:document_id)
#     end
#
#     it 'is invalid when author date is in the future' do
#       ver.should_not allow_value(1.second.from_now).for(:authored_date)
#       ver.should     allow_value(Time.zone.now).for(:authored_date)
#     end
#
#     specify 'checked date should be after or equal to authored date' do
#       unchk = create(:unchecked_version,  authored_date: '2010-01-01',
#                                           checker: 'Checker')
#       %w{1990-01-01 2009-12-31}.each do |date|
#         unchk.should_not allow_value(date).for(:checked_date)
#       end
#       %w{2010-01-01 2010-01-02 2010-12-31}.each do |date|
#         unchk.should     allow_value(date).for(:checked_date)
#       end
#     end
#
#     specify 'approved date should be after or equal to checked date' do
#       unapp = create(:unapproved_version,  authored_date: '2009-12-31',
#                                            checked_date: '2010-01-01',
#                                            approver: 'Approver')
#       %w{1990-01-01 2009-12-30 2009-12-31}.each do |date|
#         unapp.should_not allow_value(date).for(:approved_date)
#       end
#       %w{2010-01-01 2010-01-02 2010-12-31}.each do |date|
#         unapp.should     allow_value(date).for(:approved_date)
#       end
#     end
#
#     specify 'withdrawn date should be after or equal to authored date' do
#       unchk = create(:unchecked_version,  authored_date: '2010-01-01',
#                                           withdrawer: 'Withdrawer')
#       %w{1990-01-01 2009-12-30 2009-12-31}.each do |date|
#         unchk.should_not allow_value(date).for(:withdrawn_date)
#       end
#       %w{2010-01-01 2010-02-01 2010-12-31}.each do |date|
#         unchk.should     allow_value(date).for(:withdrawn_date)
#       end
#     end
#
#     specify 'state should be draft when not checked' do
#       create(:unchecked_version).state.should eq(:draft)
#       create(:checked_version).state.should_not eq(:draft)
#       create(:approved_version).state.should_not eq(:draft)
#       create(:withdrawn_version).state.should_not eq(:draft)
#     end
#
#     specify 'state should be checked when not approved' do
#       create(:unapproved_version).state.should eq(:checked)
#       create(:draft_version).state.should_not eq(:checked)
#       create(:approved_version).state.should_not eq(:checked)
#       create(:withdrawn_version).state.should_not eq(:checked)
#     end
#
#     specify 'state should be approved when approved and not withdrawn' do
#       create(:approved_version).state.should eq(:approved)
#       create(:draft_version).state.should_not eq(:approved)
#       create(:checked_version).state.should_not eq(:approved)
#       create(:withdrawn_version).state.should_not eq(:approved)
#     end
#
#     specify 'state should be withdrawn when withdrawn' do
#       create(:withdrawn_version).state.should eq(:withdrawn)
#       create(:approved_version).state.should_not eq(:withdrawn)
#       create(:draft_version).state.should_not eq(:withdrawn)
#       create(:checked_version).state.should_not eq(:withdrawn)
#     end
#   end
#
#   context 'associations:' do
#     it {should belong_to :document }
#   end
end
