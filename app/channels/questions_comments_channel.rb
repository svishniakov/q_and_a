class QuestionsCommentsChannel < ApplicationCable::Channel
  def follow
    stream_from 'question_comments'
  end
end