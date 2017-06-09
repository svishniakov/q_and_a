class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_question, only: %i[show edit update destroy]
  before_action :check_user, only: %i[edit update destroy]

  def index
    @questions = Question.all
  end

  def show
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      flash[:success] = 'Question was successfully created!'
      redirect_to @question
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      flash[:success] = 'Question was successfully updated!'
      redirect_to questions_path
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    flash[:notice] = 'Question was successfully deleted!'
    redirect_to questions_path
  end

  private

  def set_question
    @question = Question.find(params[:id])
    @user = @question.user
  end

  def question_params
    params.require(:question).permit(:title, :body, :user_id)
  end
end
