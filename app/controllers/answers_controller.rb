class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question, only: %i[create]
  before_action :set_answer_params, only: %i[edit update destroy]
  before_action :check_user, only: %i[edit update destroy]

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    if @answer.save
      flash[:notice] = 'Answer was successully created!'
      redirect_to question_path(@question)
    else
      flash[:error] = 'Answer not saved'
      redirect_to question_path(@question)
    end
  end

  def update
    if @answer.update(answer_params)
      flash[:notice] = 'Answer was successfully updated!'
      redirect_to question_path(@question)
    else
      flash[:error] = 'Answer not updated'
      redirect_to question_path(@question)
    end
  end

  def destroy
    @answer.destroy
    flash[:notice] = 'Answer successfully deleted'
    redirect_to question_path(@question)
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
    @user = @answer.user
    @question ||= @answer.question
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
