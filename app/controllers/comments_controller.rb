class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: :destroy
  after_action :publish_comment, only: :create

  def create
    @comment = @commentable.comments.build comment_params
    @comment.user = current_user
    @comment.save
  end

  def destroy
    @comment.destroy
  end

  private

  def publish_comment
    return if @comment.errors.any?
    ActionCable.server.broadcast(
        "#{@commentable.class.to_s.downcase}_comments",
        ApplicationController.render(json: { commentable: @commentable, comment: @comment })
    )
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end