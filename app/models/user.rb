class User < ApplicationRecord
  attr_accessor :password

  validates_confirmation_of :password
  validates_confirmation_of :email
  validates :email, uniqueness: {case_sensitive: false}

  before_save :hash_password

  def hash_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def self.authenticate(email,password)
    user = User.where("LOWER(email) = ?", email.downcase).first
    if user && user.password_hash && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
end
