require 'rails_helper'

RSpec.describe AuthenticateUser do
  let(:user) { create(:user) }
  # valid request subject
  subject(:valid_auth_obj) { described_class.new(user.username, user.password) }
  # invalid request subject
  subject(:invalid_auth_obj) { described_class.new('foo', 'bar') }

  # Test suite for AuthenticateUser#call
  describe '#call' do
    # returns a token when a valid request is made
    context 'when valid credentials' do
      it 'returns an auth token' do
        token = valid_auth_obj.call
        expect(token).not_to be_nil
      end
    end

    # raises a Authentication Error when an invalid request is made
    context 'when invalid credentials' do
      it 'raises an authentication error' do
        expect { invalid_auth_obj.call }
            .to raise_error(
                    ExceptionHandler::AuthenticationError,
                    /Invalid credentials/
                )
      end
    end
  end
end