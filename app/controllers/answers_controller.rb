class AnswersController < ApplicationController
  before_action :set_question, only: %i[index new create]
  before_action :set_answer, only: %i[show edit update]

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
    if @answer.save
      flash[:notice] = 'Answer was successully created!'
      redirect_to @answer
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

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, :question_id)
  end
end
