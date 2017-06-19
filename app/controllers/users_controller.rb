class UsersController < ApplicationController
  #skip authorization of the token when a user is creating a new account
  skip_before_action :authorize_request, only: :signup
  before_action :set_current_user, only: [:show, :update, :destroy]

  ##
  # Create a new User instance
  #
  # POST /users
  def create
    # ExceptionHandler module will handle an invalid user
    # if its invalid on create!
    @user = User.create!(user_params)
    json_response(@user, :created)
  end


  def signup
    user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.username, user.password).call
    response = { message: Message.account_created, auth_token: auth_token }
    json_response(response, :created)
  end

  ##
  # View all Users
  #
  # GET /users
  def index
    @users = User.all.paginate(page: params[:page], per_page: 20)
    json_response(@users)
  end

  ##
  # View a specific User
  #
  # GET /users/:id
  def show
    json_response(@user)
  end

  # ##
  # #  A user may only edit their own account.
  # #
  # def edit
  #   # will only return the user if the user it attempting to edit their own account.
  #   json_response(@user) unless current_user != @user
  # end

  ##
  # Update User instance
  #
  # A user may only edit their own account.
  #
  # PUT /users/:id
  def update
    @user.update(user_params) unless current_user != @user
    head :no_content
  end

  ##
  # Deletes User instance
  #
  # A user may only destroy their own user account.
  #
  # DELETE /users/:id
  def destroy
    @user.destroy unless current_user != @user
    head :no_content
  end

  private

  def user_params
    params.permit(:name, :username, :password, :password_confirmation)#, :auth_token
  end

  def set_current_user
    @user = User.find(params[:id])
  end
end
