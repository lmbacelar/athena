class User < ActiveRecord::Base
  # # # # # Includes / Extends          # # # # #
  has_secure_password

  # # # # # Constants                   # # # # #
  # # # # # Instance Variables          # # # # #
  # # # # # Callbacks                   # # # # #
  before_create { generate_token(:auth_token) }

  # # # # # Attr_accessible / protected # # # # #
  attr_accessible :email, :name, :password, :password_confirmation

  # # # # # Associations / Delegates    # # # # #
  has_many :memberships, dependent: :destroy
  has_many :roles, through: :memberships
  has_many :groups, through: :memberships

  # # # # # Scopes                      # # # # #
  # # # # # Validations                 # # # # #
  validates :email, presence: true, uniqueness: true
  validates_presence_of :password, on: :create

  # # # # # Public Methods              # # # # #
  def short_email
    email[/(^.*)@/,1]
  end

  def to_s
    name || email
  end

  def send_activation
    generate_token(:activation_token)
    self.activation_sent_at = Time.zone.now
    save!
    UserMailer.activation(self).deliver
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  # # # # # Private Methods             # # # # #
end
