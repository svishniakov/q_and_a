class Answers::CommentsController < CommentsController
  before_action :set_commentable, only: :create

  private

  def set_commentable
    @commentable = Answer.find(params[:answer_id])
  end
end