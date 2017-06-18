require 'rails_helper'

RSpec.describe AuthorizeApiRequest, type: :auth do
  let(:user) { create(:user) }
  ##TODO Mock `Authorization` header
  let(:header) { { 'Authorization' => token_generator(user.id) } }
  ##TODO  Invalid request subject
  subject(:invalid_request_obj) { described_class.new({}) }
  ##TODO  Valid request subject
  subject(:request_obj) { described_class.new(header) }

  ##TODO  Test Suite for AuthorizeApiRequest#call
  ##TODO  This is our entry point into the service class
  describe '#call' do
    ##TODO  returns user object when request is valid
    context 'when valid request' do
      it 'returns user object' do
        result = request_obj.call
        expect(result[:user]).to eq(user)
      end
    end

    ##TODO  returns error message when invalid request
    context 'when invalid request' do
      context 'when missing token' do
        it 'raises a MissingToken error' do
          expect { invalid_request_obj.call }
              .to raise_error(ExceptionHandler::MissingToken, 'Missing token')
        end
      end

      context 'when invalid token' do
        subject(:invalid_request_obj) do
          ##TODO  custom helper method `token_generator`
          described_class.new('Authorization' => token_generator(5))
        end

        it 'raises an InvalidToken error' do
          expect { invalid_request_obj.call }
              .to raise_error(ExceptionHandler::InvalidToken, /Invalid token/)
        end
      end

      context 'when token is expired' do
        let(:header) { { 'Authorization' => expired_token_generator(user.id) } }
        subject(:request_obj) { described_class.new(header) }

        it 'raises ExceptionHandler::ExpiredSignature error' do
          puts request_obj.inspect
          expect { request_obj.call }
              .to raise_error(
                      ExceptionHandler::ExpiredSignature,
                      /Signature has expired/
                  )
        end
      end
    end
  end
end