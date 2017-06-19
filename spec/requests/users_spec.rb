require 'rails_helper'

# include the autherization headers in each request
RSpec.describe 'Users API', type: :request do
  let!(:user_1) { FactoryGirl.create(:user)}
  let!(:user_2) { FactoryGirl.create(:user)}
  let!(:user) { FactoryGirl.create(:user)}
  let!(:users) { [user_1, user_2] }
  let(:user_id) { users.first.id }
  let(:headers) { valid_headers }

  # Test suite for GET /users
  describe 'GET /users' do
    # make HTTP get request before each example
    before { get '/users', params: {}, headers: headers }

    it 'returns users' do
      expect(JSON.parse(response.body)).not_to be_empty
      expect(JSON.parse(response.body).size).to eq(3)
    end

    it 'returns HTTP status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /users/:id
  describe 'GET /users/:id' do
    before { get "/users/#{user_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the user' do
        puts JSON.parse(response.body).inspect
        expect(JSON.parse(response.body)).not_to be_empty
        expect(JSON.parse(response.body)['id']).to eq(user_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:user_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

  # Test suite for POST /users
  describe 'POST /users' do
    # valid json payload
    let(:valid_attributes) do
      { name: 'Learn Elm', username: 'username', password: 'password' }.to_json
    end

    context 'when the request is valid' do
      before { post '/users', params: valid_attributes, headers: headers }

      it 'creates a user' do
        expect(JSON.parse(response.body)['name']).to eq('Learn Elm')
        expect(JSON.parse(response.body)['username']).to eq('username')
        expect(JSON.parse(response.body)['password']).to eq('password')
        # #Auth_token is randomly generated so this test should now be aware of it's
        # #value.
        # expect(JSON.parse(response.body)['auth_token']).to_not be_blank
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end


    #   context 'when request is invalid' do
    #     let(:valid_attributes) { { title: nil }.to_json }
    #     before { post '/todos', params: valid_attributes, headers: headers }
    #     # [...]
    #   end
    # context 'when the request is invalid' do
    #   before { post '/users', params: { name: 'Foobar' } }
    #
    #   it 'returns status code 422' do
    #     expect(response).to have_http_status(422)
    #   end
    #
    #   #TODO: The following tests
    #   # it 'returns a validation failure message for missing name' do
    #   #   expect(response.body)
    #   #       .to match(/Validation failed: Name by can't be blank/)
    #   # end
    #
    #   # it 'returns a validation failure message for missing username' do
    #   #   expect(response.body)
    #   #       .to match(/Validation failed: Name by can't be blank/)
    #   # end
    #
    #   # it 'returns a validation failure message for missing password' do
    #   #   expect(response.body)
    #   #       .to match(/Validation failed: Name by can't be blank/)
    #   # end
    # end
  end

  # Test suite for PUT /users/:id
  describe 'PUT /users/:id' do
    let(:valid_attributes) { { name: 'Learn Elm', username: 'username', password: 'password' }.to_json }#, auth_token: 'auth_token'

    context 'when the record exists' do
      before { put "/users/#{user_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /users/:id
  describe 'DELETE /users/:id' do
    before { delete "/users/#{user_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end

  # User signup test suite
  describe 'POST /signup' do
    let(:user) { build(:user) }
    let(:headers) { valid_headers.except('Authorization') }
    let(:valid_attributes) do
      attributes_for(:user, password: user.password, password_confirmation: user.password)
    end
    context 'when valid request' do
      before { post '/signup', params: valid_attributes.to_json, headers: headers }

      it 'creates a new user' do
        expect(response).to have_http_status(201)
      end

      it 'returns success message' do
        # puts JSON.parse(response.body).inspect
        expect(JSON.parse(response.body)['message']).to match(/Account created successfully/)
      end

      it 'returns an authentication token' do
        expect(JSON.parse(response.body)['auth_token']).not_to be_nil
      end
    end

    context 'when invalid request' do
      before { post '/signup', params: {}, headers: headers }

      it 'does not create a new user' do
        expect(response).to have_http_status(422)
      end

      it 'returns failure message' do
        expect(JSON.parse(response.body)['message'])
            .to match(/Validation failed: Password can't be blank, Name can't be blank, Username can't be blank, Password digest can't be blank/)
      end
    end
  end
end
