require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  attr_accessor :password

  before_save :encrypt_user_password

  validates :email, presence: true, uniqueness: true, on: :create
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :password, presence: true, confirmation: true, length: { in: 3..20 }, on: :create

  def self.authenticate_for(email, password)
    user = where(email: email).first
    return user if user && user.password_hash_mached_for?(password)
  end

  def password_hash_mached_for?(user_input_password)
    self.password_hash == BCrypt::Engine.hash_secret(user_input_password, self.password_salt)
  end

  private

  # self refrence is necessay below, otherwise nil hash and salt generation
  def encrypt_user_password
    if password
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

end

