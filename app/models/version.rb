class Version < ActiveRecord::Base

  # # # # # Callbacks
  before_validation :increment_number
  after_create      :create_state_change

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
    # TODO: maybe replace after_create callback with initialize
    #       overloading on state_machine
    after_transition :add_state_change

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
  def create_state_change
    self.state_changes.create state: human_state_name, user: 'User'
  end

  def add_state_change(transition)
    self.state_changes.create state: transition.human_to_name, user: 'User'
  end

  def increment_number
    if document
      self.number = 1 + (document.versions.maximum(:number) || 0)
    end
  end
end
