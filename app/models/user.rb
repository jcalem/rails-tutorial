class User < ApplicationRecord
  attr_accessor :password

  validates_confirmation_of :password
  validates_confirmation_of :email
  validate :email, uniqueness: {case_sensitive: false}

  before_save :hash_password
end
