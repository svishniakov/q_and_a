class AnswersController < ApplicationController
  include Voted
  before_action :authenticate_user!
  before_action :set_question, only: %i[create]
  before_action :set_answer_params, only: %i[update destroy best]
  before_action :check_user, only: %i[update destroy]

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save
  end

  def update
    @answer.update(answer_params)
  end

  def destroy
    @answer.destroy
    flash[:notice] = 'Answer successfully deleted'
    redirect_to question_path(@question)
  end

  def best
    if current_user.author_of?(@answer.question)
      @answer.best!
    else
      head :forbidden
    end
  end

  private

  def check_user
    unless current_user.author_of?(@answer)
      flash[:alert] = 'You have no sufficient rights to continue'
      redirect_to @question
    end
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer_params
    @answer = Answer.find(params[:id])
    @question ||= @answer.question
  end

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:file])
  end
end
