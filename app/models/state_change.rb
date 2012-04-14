class StateChange < ActiveRecord::Base
  # # # # # Validations
  validates :user, presence: true
  validates :state, presence: true
  validates :version, presence: true

  # # # # # Associations
  belongs_to :version

  # # # # # Public Methods
  # # # # # Instance Methods
  def to_s
    "Set as #{state} by #{user} on #{updated_at}"
  end
end
