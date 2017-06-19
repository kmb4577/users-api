require 'rails_helper'


# Test suite for the User model
RSpec.describe User, type: :model do
  # Association test
  it { should have_many(:posts).dependent(:destroy)}

  # Validation tests
  it { should validate_presence_of(:name)}
  it { should validate_presence_of(:username)}
  it { should validate_presence_of(:password)}
  it { should validate_presence_of(:password_digest) }
end