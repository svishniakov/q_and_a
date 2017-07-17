class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachable

  scope :best_first, -> { order(best: :desc) }

  validates :body, presence: true

  accepts_nested_attributes_for :attachments

  def best!
    transaction do
      question.answers.update_all(best: false)
      update!(best: true)
    end
  end
end
