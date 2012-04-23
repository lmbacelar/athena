class Role < ActiveRecord::Base
  # # # # # Includes / Extends          # # # # #
  # # # # # Constants                   # # # # #
  # # # # # Instance Variables          # # # # #
  # # # # # Callbacks                   # # # # #
  # # # # # Attr_accessible / protected # # # # #
  # # # # # Associations / Delegates    # # # # #
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :groups, through: :memberships

  # # # # # Scopes                      # # # # #
  scope :for_group, lambda { |g| joins(:groups).where('groups.name' => g.to_s).uniq }

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
