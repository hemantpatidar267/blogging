class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show destroy]
  load_and_authorize_resource

  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find_by(id: params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @post
    else
      flash[:notice] = @comment.errors.full_messages
      redirect_to @post, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
    @post = Post.find_by(id: params[:post_id])
    @comment = Comment.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:post_id])
    @comment = @post.comments.find_by(id: params[:id])
    if @comment.update(comment_params)
      redirect_to @post, notice: 'Comment updated successfully.'
    else
      render 'edit'
    end
  end

  def index
    @comment = Comment.all
  end

  def destroy
    @comment.destroy
    redirect_to posts_path, status: :see_other
  end

  private

  def set_comment
    @comment = Comment.find_by(id: params[:id])
  end

  def comment_params
    params.require(:comment).permit(:context)
  end
end
