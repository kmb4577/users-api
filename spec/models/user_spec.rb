require 'rails_helper'


# Test suite for the User model
RSpec.describe User, type: :model do
  # Association test
  it { should have_many(:posts).dependent(:destroy)}

  # Validation tests
  it { should validate_presence_of(:name)}
  it { should validate_presence_of(:username)}
  it { should validate_presence_of(:password)}
  it { should validate_presence_of(:auth_token)}

  it { should validate_uniqueness_of(:auth_token)}
  #TODO check the following tests meaning
  it { should respond_to(:auth_token) }
  #TODO: Add more tests for this
  # #No user can have the same username and password
  # validates_uniqueness_of :username, scope: [:password]


  describe "Generate Auth Token:: " do
    # it "is generated on user create" do
      # Devise.stub(:friendly_token).and_return("auniquetoken123")
      # @user.generate_authentication_token!
      # expect(@user.auth_token).to eql "auniquetoken123"
    # end
    # it "is different then any existing users token"
  end
end