require 'spec_helper'

describe Version do
  describe 'validations:' do
    it { should validate_presence_of :number }
    it { should validate_presence_of :document }
  end

  describe 'associations:' do
    it { should belong_to :document }
    it { should have_many(:state_changes).dependent(:destroy) }
  end

  describe 'state_machine:' do
    let(:vsn) { create(:version) }

    describe 'events:' do
      events = [:check, :publish, :withdraw, :discard]
      specify "should be [#{events.join(', ')}]" do
        (events - vsn.events).count.should eq(0)
        (vsn.events - events).count.should eq(0)
      end
    end

    describe 'states:' do
      states = [:initiated, :draft, :published, :withdrawn, :discarded]
      specify "should be [#{states.join(', ')}]" do
        (states - vsn.states).count.should eq(0)
        (vsn.states - states).count.should eq(0)
      end

      describe ':initiated' do
        it 'should be the initial state' do
          vsn.initiated?.should be_true
        end
        it 'should change to :draft on check' do
          vsn.check
          vsn.draft?.should be_true
        end
        it 'should change to :discarded on discard' do
          vsn.discard
          vsn.discarded?.should be_true
        end
        ['publish!', 'withdraw!'].each do |action|
          it "should raise an error for #{action}" do
            lambda {vsn.send(action)}.should raise_error
          end
        end
      end

      describe ':draft' do
        it 'should change to :published on publish' do
          vsn.check; vsn.publish
          vsn.published?.should be_true
        end
        it 'should change to :discarded on discard' do
          vsn.check; vsn.discard
          vsn.discarded?.should be_true
        end
        it 'should not change on check' do
          vsn.check; vsn.check
          vsn.draft?.should be_true
        end
        it 'should raise an error for withdraw' do
          vsn.check
          vsn.withdraw.should raise_error
        end
      end

      describe ':published' do
        it 'should change to :withdrawn on withdraw' do
          vsn.check; vsn.publish; vsn.withdraw
          vsn.withdrawn?.should be_true
        end
        it 'should not change on publish' do
          vsn.check; vsn.publish; vsn.publish
          vsn.published?.should be_true
        end
        ['check!', 'discard!'].each do |action|
          it "should raise an error for #{action}" do
            vsn.check; vsn.publish
            lambda {vsn.send(action)}.should raise_error
          end
        end
      end

      describe ':withdrawn' do
        it 'should change to :published on publish' do
          vsn.check; vsn.publish; vsn.withdraw; vsn.publish
          vsn.published?.should be_true
        end
        it 'should not change on withdraw' do
          vsn.check; vsn.publish; vsn.publish; vsn.withdraw; vsn.withdraw
          vsn.withdrawn?.should be_true
        end
        ['check!', 'discard!'].each do |action|
          it "should raise an error for #{action}" do
            vsn.check; vsn.publish; vsn.withdraw
            lambda {vsn.send(action)}.should raise_error
          end
        end
      end

      describe ':discarded' do
        it 'should not change on discard' do
          vsn.discard; vsn.discard
          vsn.discarded?.should be_true
          vsn.check; vsn.discard; vsn.discard
          vsn.discarded?.should be_true
        end
        ['check!', 'discard!', 'publish!', 'withdraw!'].each do |action|
          it "should raise an error for #{action}" do
            vsn.discard
            lambda {vsn.send(action)}.should raise_error
          end
        end
      end
    end
  end

  describe 'state_changes:' do
    let(:vsn) { create(:version) }
    # This assumes tests from database commit to time test can run within :secs seconds.
    # If tests fail, check this timing, specially when having slow db connections
    let(:secs) { 1 }

    specify 'should be created on new version' do
      vsn.state_changes.should_not be_nil
      vsn.state_changes.count.should eq(1)
      (Time.now - vsn.last_state_change.created_at).should be < secs
      vsn.last_state_change.state.should eq(vsn.state)
    end
    specify 'should be added on state transition' do
      sleep secs; vsn.check
      vsn.state_changes.count.should eq(2)
      (Time.now - vsn.last_state_change.created_at).should be < secs
      vsn.last_state_change.state.should eq(vsn.state)
    end
    specify 'should not be changed on state unchanged' do
      vsn.check; sleep secs; vsn.check
      vsn.state_changes.count.should eq(2)
      (Time.now - vsn.last_state_change.updated_at).should be > secs
      vsn.last_state_change.state.should eq(vsn.state)
    end
    specify 'should not be added on raised error' do
      vsn.withdraw; sleep secs
      vsn.state_changes.count.should eq(1)
      (Time.now - vsn.last_state_change.updated_at).should be > secs
      vsn.last_state_change.state.should eq(vsn.state)
    end
  end

end
