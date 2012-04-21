class Version < ActiveRecord::Base

  # # # # # Callbacks
  before_validation :increment_number

  # # # # # Attr Protection
  # TODO: change to attr_accessible when accessible
  #       attrs are defined (content ...)
  attr_protected :number, :state

  # # # # # Validations
  validates :number, presence: true, uniqueness: { scope: :document_id }
  validates :document, presence: true

  # # # # # Associations
  belongs_to :document, touch: true
  has_many :state_changes, dependent: :destroy

  # # # # # State Machine Setup
  state_machine initial: :initiated do
    before_transition do |version, transition|
      # Succesfull transitions require passing a :user parameter. This is
      # passed to track which user changed the state.
      state_change = version.state_changes.build(state: transition.human_to_name,
                                                 user:  transition.args[0][:user])
      throw :halt unless state_change.save
    end

    event :check    do ( transition :initiated           => :draft     ) end
    event :publish  do ( transition [:draft, :withdrawn] => :published ) end
    event :withdraw do ( transition :published           => :withdrawn ) end
    event :discard  do ( transition [:initiated, :draft] => :discarded ) end
  end

  # # # # # Public Methods
  # # # # # Class Methods
  def self.states
    state_machine.states.map &:name
  end
  def self.events
    state_machine.events.map &:name
  end

  # # # # # Instance Methods
  def states
    self.class.states
  end
  def events
    self.class.events
  end

  def last_state_change
    self.state_changes.order('created_at').last
  end

  # # # # # Private Methods
private
  def increment_number
    if document
      self.number = 1 + (document.versions.maximum(:number) || 0)
    end
  end
end
