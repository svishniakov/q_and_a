module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable, autosave: true
  end

  def rating
    votes.sum(:value)
  end

  def vote(user, type)
    value = type == 'plus' ? 1 : -1
    votes.create!(user: user, value: value)
  end

  def voted?(user)
    Vote.where(user: user, votable: self).exists?
  end

  def clear_vote(user)
    votes.where(user: user, votable: self).destroy_all
  end
end