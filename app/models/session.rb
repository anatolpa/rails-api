class Session < ActiveRecord::Base
  validates :token, uniqueness: true, presence: true
  validates :user, presence: true

  belongs_to :user

  def self.authorize_user_with_credentials(email, password)
    user = User.find_by(email: email).try(:authenticate, password)
    raise UnauthorizedError.new unless user

    self.create_for_user user
  end

  def self.authorize_user_with_token(token)
    session = Session.find_by token: token
    raise UnauthorizedError.new unless session

    session
  end

  protected

  def self.generate_token
    SecureRandom.base64(ENV['AUTH_TOKEN_SIZE'].to_i)
  end

  def self.create_for_user(user)
    Session.create! user: user, token: self.generate_unique_token
  end

  def self.generate_unique_token
    token = self.generate_token

    while Session.find_by token: token
      token = self.generate_token
    end

    token
  end
end
