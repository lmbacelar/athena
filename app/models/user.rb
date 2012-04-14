class User < ActiveRecord::Base
  has_secure_password
  before_create { generate_token(:auth_token) }

  attr_accessible :email, :password, :password_confirmation
  validates_presence_of :email, :password
  validates_uniqueness_of :email

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end
