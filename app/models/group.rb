class Group < ActiveRecord::Base
  # # # # # Includes / Extends          # # # # #
  # # # # # Constants                   # # # # #
  # # # # # Instance Variables          # # # # #
  # # # # # Callbacks                   # # # # #
  # # # # # Attr_accessible / protected # # # # #
  # # # # # Associations / Delegates    # # # # #
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :roles, through: :memberships

  # # # # # Scopes                      # # # # #
  scope :with_role, lambda { |r| joins(:roles).where('roles.name' => r.to_s).uniq }

  # # # # # Validations                 # # # # #
  validates :name, presence: true, uniqueness: true, length: { maximum: 10 }

  # # # # # Public Methods              # # # # #
  def to_s
    name
  end

  def to_param
    name.parameterize
  end

  # # # # # Private Methods             # # # # #
end
