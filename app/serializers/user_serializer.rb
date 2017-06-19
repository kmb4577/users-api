# Allows client to access a user's posts with one API request rather than 2
class UserSerializer < ActiveModel::Serializer
  #the following attributes will be serialized
  attributes :id,  :name, :username, :password, :created_at, :updated_at#, :password_digest
  has_many :posts
end
