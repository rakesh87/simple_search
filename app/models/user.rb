require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  attr_accessor :password

  before_save :encrypt_user_password

  validates_presence_of :email
  validates_presence_of :password, on: :create
  validates_confirmation_of :password, on: :create

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

