module Voted
  extend ActiveSupport::Concern

  included do
    before_action :set_votable, only: %i[plus minus clear_vote]
    respond_to :json, :html, :js
  end

  def plus
    vote('plus')
  end

  def minus
    vote('minus')
  end

  def clear_vote
    @votable.clear_vote(current_user) if @votable.voted?(current_user)
    respond_success
  end

  private

  def set_votable
    klass = controller_name.classify.constantize
    @votable = klass.find(params[:id])
  end

  def vote(type)
    return respond_voted if @votable.voted?(current_user)
    return respond_vote_author if current_user.author_of?(@votable)
    if @votable.vote(current_user, type)
      respond_success
    else
      respond_error('Something went wrong')
    end
  end

  def respond_voted
    respond_error('You can vote only once')
  end

  def respond_success
    respond_json(@votable.rating)
  end

  def respond_vote_author
    respond_error('Author can\'t vote')
  end

  def respond_json(content, status = 200)
    render json: { id: @votable.id, content: content, controller: controller_name.singularize }, status: status
  end

  def respond_error(message)
    respond_json(message, 403)
  end
end