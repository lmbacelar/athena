require 'spec_helper'

describe Version do
  describe 'validations:' do
    it { should validate_presence_of :number }
    it { should validate_presence_of :document_id }
  end

  describe 'associations:' do
    it { should belong_to :document }
    it { should have_many(:state_changes).dependent(:destroy) }
  end

  describe 'state_machine:' do
    let(:vsn) { create(:version) }
    let(:usr) { create(:user) }

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
          vsn.check(user: usr)
          vsn.draft?.should be_true
        end
        it 'should change to :discarded on discard' do
          vsn.discard(user: usr)
          vsn.discarded?.should be_true
        end
        ['publish!', 'withdraw!'].each do |action|
          it "should raise an error for #{action}" do
            lambda {vsn.send(action, user: usr)}.should raise_error
          end
        end
      end

      describe ':draft' do
        it 'should change to :published on publish' do
          vsn.check(user: usr); vsn.publish(user: usr)
          vsn.published?.should be_true
        end
        it 'should change to :discarded on discard' do
          vsn.check(user: usr); vsn.discard(user: usr)
          vsn.discarded?.should be_true
        end
        it 'should not change on check' do
          vsn.check(user: usr); vsn.check(user: usr)
          vsn.draft?.should be_true
        end
        it 'should raise an error for withdraw' do
          vsn.check(user: usr)
          vsn.withdraw(user: usr).should raise_error
        end
      end

      describe ':published' do
        it 'should change to :withdrawn on withdraw' do
          vsn.check(user: usr); vsn.publish(user: usr); vsn.withdraw(user: usr)
          vsn.withdrawn?.should be_true
        end
        it 'should not change on publish' do
          vsn.check(user: usr); vsn.publish(user: usr); vsn.publish(user: usr)
          vsn.published?.should be_true
        end
        ['check!', 'discard!'].each do |action|
          it "should raise an error for #{action}" do
            vsn.check(user: usr); vsn.publish(user: usr)
            lambda {vsn.send(action, user: usr)}.should raise_error
          end
        end
      end

      describe ':withdrawn' do
        it 'should change to :published on publish' do
          vsn.check(user: usr); vsn.publish(user: usr); vsn.withdraw(user: usr); vsn.publish(user: usr)
          vsn.published?.should be_true
        end
        it 'should not change on withdraw' do
          vsn.check(user: usr); vsn.publish(user: usr); vsn.publish(user: usr)
          vsn.withdraw(user: usr); vsn.withdraw(user: usr)
          vsn.withdrawn?.should be_true
        end
        ['check!', 'discard!'].each do |action|
          it "should raise an error for #{action}" do
            vsn.check(user: usr); vsn.publish(user: usr); vsn.withdraw(user: usr)
            lambda {vsn.send(action, user: usr)}.should raise_error
          end
        end
      end

      describe ':discarded' do
        it 'should not change on discard' do
          vsn.discard(user: usr); vsn.discard(user: usr)
          vsn.discarded?.should be_true
          vsn.check(user: usr); vsn.discard(user: usr); vsn.discard(user: usr)
          vsn.discarded?.should be_true
        end
        ['check!', 'discard!', 'publish!', 'withdraw!'].each do |action|
          it "should raise an error for #{action}" do
            vsn.discard(user: usr)
            lambda {vsn.send(action, user: usr)}.should raise_error
          end
        end
      end
    end
  end

  describe 'state_changes:' do
    let(:vsn) { create(:version) }
    let(:usr) { create(:user) }

    # This assumes tests from database commit to time test can run within :secs seconds.
    # If tests fail, check this timing, specially when having slow db connections
    let(:secs) { 1 }

    specify 'should be empty on new version' do
      vsn.state_changes.should be_empty
    end
    specify 'should be added on state transition' do
      sleep secs; vsn.check(user: usr)
      vsn.state_changes.count.should eq(1)
      (Time.now - vsn.last_state_change.created_at).should be < secs
      vsn.last_state_change.state.should eq(vsn.state)
    end
    specify 'should not be changed on state unchanged' do
      vsn.check(user: usr); sleep secs; vsn.check(user: usr)
      vsn.state_changes.count.should eq(1)
      (Time.now - vsn.last_state_change.updated_at).should be > secs
      vsn.last_state_change.state.should eq(vsn.state)
    end
    specify 'should not be added on raised error' do
      vsn.check(user: usr); vsn.withdraw(user: usr); sleep secs
      vsn.state_changes.count.should eq(1)
      (Time.now - vsn.last_state_change.updated_at).should be > secs
      vsn.last_state_change.state.should eq(vsn.state)
    end
  end
end
