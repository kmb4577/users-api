class User < ApplicationRecord
  # has_secure_password

  has_many :posts, dependent: :destroy
  validates_presence_of :name, :username, :password, :auth_token
  validates_uniqueness_of :auth_token
  #No user can have the same username and password
  validates_uniqueness_of :username, scope: [:password]

  #TODO: If user can't have an extra attribute of an auth_token
  # then change the following functions so they generate a default
  # password if one is not created
  before_create :generate_auth_token!


  def authenticate(unencrypted_password)
    BCrypt::Password.new(cur_password).is_password?(unencrypted_password) && self
  end


  def cur_password=(unencrypted_password)
    if unencrypted_password.nil?
      self.password = nil
    elsif !unencrypted_password.empty?
      @password = unencrypted_password
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      self.password = BCrypt::Password.create(unencrypted_password, cost: cost)
    end
  end

  private

  #CHANGE THIS UP
  def generate_auth_token!
    begin
      self.auth_token = Devise.friendly_token
    end while self.class.exists?(auth_token: auth_token)
  end
end
