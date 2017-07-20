class Answer < ApplicationRecord
  include Attachable
  include Votable
  belongs_to :question
  belongs_to :user

  scope :best_first, -> { order(best: :desc) }

  validates :body, presence: true

  def best!
    transaction do
      question.answers.update_all(best: false)
      update!(best: true)
    end
  end
end
