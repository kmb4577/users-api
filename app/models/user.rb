class User < ApplicationRecord
  has_many :posts
  validates_presence_of :name, :username, :password
end
