class User < ActiveRecord::Base
  validates :user_name, :session_token,
    presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  before_validation :ensure_session_token

  attr_reader :password

  def self.get_session_token
    SecureRandom.urlsafe_base64
  end

  def reset_session_token!
    self.session_token = self.class.get_session_token
    self.save!
    self.session_token
  end

  def self.find_by_credentials(username, password)
    user = self.find_by(user_name: username)
    return user if user && user.is_password?(password)
    nil
  end

  def ensure_session_token
    self.session_token ||= self.class.get_session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  has_many(
    :cats,
    class_name: :Cat,
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many(
    :cat_rental_requests,
    class_name: :CatRentalRequest,
    primary_key: :id,
    foreign_key: :user_id
  )
end
