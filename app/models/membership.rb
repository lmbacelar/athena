class Membership < ActiveRecord::Base
  # # # # # Includes / Extends          # # # # #
  # # # # # Constants                   # # # # #
  # # # # # Instance Variables          # # # # #
  # # # # # Callbacks                   # # # # #
  # # # # # Attr_accessible / protected # # # # #
  # # # # # Associations / Delegates    # # # # #
  belongs_to :user
  belongs_to :role
  belongs_to :group

  # # # # # Scopes                      # # # # #
  # # # # # Validations                 # # # # #
  validates_presence_of :user_id, :role_id, :group_id
  validates_uniqueness_of :user_id, { scope: [:role_id, :group_id] }

  # # # # # Public Methods              # # # # #
  # # # # # Private Methods             # # # # #
end
