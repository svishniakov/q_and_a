class AnswersController < ApplicationController
  before_action :set_question, only: %i[index]
  before_action :set_answer, only: %i[show]

  def index
    @answers = @question.answers
  end

  def show
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end
end
