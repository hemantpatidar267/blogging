class PostsController < ApplicationController
  def new
    @pst = Post.new
  end

  def create
    @post = current_user.post.new(post_params)
    if @post.save!
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find_by(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
        redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def search_post
    @post =Post.where(params[:tittle])

    raise if @screen.empty?
  rescue
    flash[:notice] = "Not found"
    redirect_to theatres_path
  end

  def index
    @post = Post.all
  end

  def destroy
    @post = Post.find(parmas[:id])
    @post.destroy

    redirect_to posts_path, status: :see_other
  end

  private

  def post_params
    params.require(:post).permit(:tittle, :context )
  end
end
