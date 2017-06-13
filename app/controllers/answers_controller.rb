class AnswersController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_question, only: %i[index new create]
  before_action :set_answer_params, only: %i[show edit update destroy]
  before_action :check_user, only: %i[edit update destroy]

  def index
    @answers = @question.answers
  end

  def show
  end

  def new
    @answer = @question.answers.new
  end

  def edit
  end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    if @answer.save
      flash[:notice] = 'Answer was successully created!'
      redirect_to question_path(@question)
    else
      render :new
    end
  end

  def update
    if @answer.update(answer_params)
      flash[:notice] = 'Answer was successfully updated!'
      redirect_to @answer
    else
      render :edit
    end
  end

  def destroy
    @answer.destroy
    redirect_to questions_path
  end

  private

  def check_user
    if @answer.user != current_user
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
    params.require(:answer).permit(:body, :user_id)
  end
end
