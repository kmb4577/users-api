class PostsController < ApplicationController
  before_action :set_user
  before_action :set_user_post, only: [:show, :update, :destroy]

  ##
  # user_posts_path(:user_id)
  # GET    /users/:user_id/posts(.:format)
  #
  # Gets all the posts for the current or selected user***********CHANGE SO IT DOES THIS OR...
  #
  # Params: user_id
  def index
    json_response(Post.all)
  end

  ##
  #
  # user_post_path(:user_id, :id)
  # GET    /users/:user_id/posts/:id(.:format) posts#show
  #
  def show
    json_response(@post)
  end


  def create
    @user.posts.create!(post_params)
    json_response(@user, :created)
  end

  def update
    @post.update(post_params)
    head :no_content
  end

  def destroy
    @post.destroy
    head :no_content
  end

  private

  def post_params
    params.permit(:content)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_user_post
    @post = @user.posts.find_by!(id: params[:id]) if @user
  end
end
