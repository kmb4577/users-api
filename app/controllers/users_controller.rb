class UsersController < ApplicationController
  before_action :set_current_user, only: [:show, :update, :destroy]

  ##
  # Create a new User instance
  #
  # POST /users
  def create
    #ActiveRecord::RecordInvalid will raise if create! is invalid due to user_params passed
    #avoid deep nested if statements in the controller.
    # Thus, we rescue from this exception in the ExceptionHandler module.
    @user = User.create!(user_params)
    #TODO: Add check to make sure user is valid before calling create!
    json_response(@user, :created)
  end

  ##
  # View all Users
  #
  # GET /users
  def index
    @users = User.all
    json_response(@users)
  end

  ##
  # View a specific User
  #
  # GET /users/:id
  def show
    json_response(@user)
  end


  # def edit
  #
  # end

  ##
  # Update User instance
  #
  # PUT /users/:id
  def update
    @user.update(user_params)
    head :no_content
  end

  ##
  # Deletes User instance
  #
  # ##Only the Post owner is allowed to edit or delete their posts.
  # ##Only the User itself can edit or delete their accounts.
  #
  # DELETE /users/:id
  def destroy
    @user.destroy
    head :no_content
  end

  private

  def user_params
    params.permit(:name, :username, :password)
  end

  #TODO: take this method out if not needed. Change comments above also
  def set_current_user
    @user = User.find(params[:id])
  end
end
