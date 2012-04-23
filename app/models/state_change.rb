class StateChange < ActiveRecord::Base
  # # # # # Validations
  validates :state, presence: true
  validates :user_id, presence: true
  validates :version_id, presence: true

  # # # # # Associations
  belongs_to :user
  belongs_to :version

  # # # # # Public Methods
  # # # # # Instance Methods
  def to_s
    "Set as #{state} by #{user} on #{updated_at}"
  end
end
