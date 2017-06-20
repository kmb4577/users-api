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
    json_response(@user.posts.paginate(page: params[:page], per_page: 20))
  end

  ##
  #
  # user_post_path(:user_id, :id)
  # GET    /users/:user_id/posts/:id(.:format) posts#show
  #
  def show
    json_response(@post)
  end
  #
  # ##
  # #
  # # Only the Post owner is allowed to edit their posts.
  # #
  # #
  # def edit
  #   json_response(@post) unless !@user.posts.include?(@post)
  # end


  def create
    @user.posts.paginate(page: params[:page], per_page: 19).create!(post_params)
    json_response(@user, :created)
  end

  ##
  #
  # Only the Post owner is allowed to edit their posts.
  #
  def update
    @post.update(post_params) unless !@user.posts.include?(@post)
    head :no_content
  end

  ##
  #
  # Only the Post owner is allowed to delete their posts.
  def destroy
    @post.destroy unless @user != current_user
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
