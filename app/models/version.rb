class Version < ActiveRecord::Base
  # Validations
  validates :number, presence: true, uniqueness: { scope: :document_id }
  validates :document, presence: true

  # Associations
  belongs_to :document, touch: true
  has_many :state_changes, dependent: :destroy

  # State Machine Setup
  state_machine initial: :initiated do
    after_transition :add_state_change

    event :check do ( transition :initiated => :draft ) end
    event :publish do ( transition [:draft, :withdrawn] => :published ) end
    event :withdraw do ( transition :published => :withdrawn ) end
    event :discard do ( transition [:initiated, :draft] => :discarded ) end
  end

private
  def add_state_change(transition)
    self.state_changes.create user: 'User',
                              state: transition.human_to_name,
                              event: transition.human_event
  end
end
