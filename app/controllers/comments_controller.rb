class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: :destroy

  def create
    @comment = @commentable.comments.new comment_params
    @comment.user = current_user
    @comment.save
  end

  def destroy
    @comment.destroy
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end