class User < ApplicationRecord
  # provide helper authorization functions and
  # method for :password_digest
  has_secure_password
  has_many :posts, dependent: :destroy
  validates_presence_of :name, :username, :password, :password_digest#, :auth_token

  #No user can have the same username and password
  validates_uniqueness_of :username, scope: [:password]
end
