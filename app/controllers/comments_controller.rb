class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      @post=Post.find(params[:post_id])
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def edit
    @comment =Comment.find(params[:id])
  end

  def update
    @comment =Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to post_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def index
    @comment = Comment.all
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to posts_path, status: :see_other

  end

  private

  def comment_params
    params.permit(:context, :post_id )
  end
end
