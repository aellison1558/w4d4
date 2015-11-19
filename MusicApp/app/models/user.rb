# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  validates :email, :password_digest, :session_token, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  after_initialize :ensure_session_token!
  attr_reader :password

  def self.generate_session_token
    SecureRandom.base64
  end

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

  def reset_session_token!
    token = self.session_token = User.generate_session_token
    self.save
    token
  end

  def ensure_session_token!
    self.session_token ||= User.generate_session_token
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(given_password)
    my_password = BCrypt::Password.new(self.password_digest)
    my_password.is_password?(given_password)
  end


end
