class User < ActiveRecord::Base

  has_secure_password
  before_create { generate_token(:auth_token) }

  attr_accessible :email, :name, :password, :password_confirmation
  validates :email, presence: true, uniqueness: true
  validates_presence_of :password, on: :create

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
end
