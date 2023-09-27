class PostsController < ApplicationController

  before_action :set_post, only: %i[show edit update destroy]

  load_and_authorize_resource

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to @post
    else
      flash[:notice] = @post.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @comment = Comment.new
    render :show
  end

  def edit
  end

  def update
    if @post.update(post_params)
        redirect_to @post
    else
      flash[:notice] = @post.errors.full_messages
      render :edit, status: :unprocessable_entity
    end
  end

  def index
    if current_user.role == 'admin'
      @post = Post.paginate(page: params[:page])
    else
      @post = current_user.posts.paginate(page: params[:page])
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, status: :see_other
  end

  private

  def set_post
    @post = Post.find_by(id: params[:id])
  end

  def post_params
    params.require(:post).permit(:tittle, :context, :blog_pic )
  end
end
