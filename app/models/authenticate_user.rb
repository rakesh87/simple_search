require 'bcrypt'

class AuthenticateUser
  include BCrypt

  def self.authenticate_for(user_email, user_password)
    user = where(email: user_email).first
    return user if user && user.password_hash == BCrypt::Engine.hash_secret(user_password, user.password_salt)
  end

end
