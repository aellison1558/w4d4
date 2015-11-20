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
  attr_reader :password

  validates(
    :email,
    :password_digest,
    :session_token,
    presence: true,
    uniqueness: true
  )
  validates :password, length: { minimum: 6, allow_nil: true }
  after_initialize :ensure_session_token!, :ensure_activation_token!

  has_many :notes


  def self.generate_token
    SecureRandom.urlsafe_base64(18)
  end

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    user && user.is_password?(password) ? user : nil
  end

  def reset_session_token!
    self.session_token = User.generate_token
    self.save
    self.session_token
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  private

  def ensure_session_token!
    self.session_token ||= User.generate_token
  end

  def ensure_activation_token!
    self.activation_token ||= User.generate_token
  end

end
