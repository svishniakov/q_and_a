require 'rails_helper'

RSpec.shared_examples 'votable' do
  it { should have_many(:votes) }

  votable_klass = described_class.to_s.underscore.to_sym
  let(:votable) { create(votable_klass) }
  let(:users) { create_list(:user, 2) }

  describe '#rating' do
    it 'should sum values from votes' do
      votable.vote(users[0], 'plus')
      votable.vote(users[1], 'plus')
      expect(votable.rating).to eq 2
    end
  end

  describe '#vote' do
    it 'should increase rating' do
      votable.vote(users[0], 'plus')
      expect(votable.rating).to eq 1
    end
    it 'should discrease rating' do
      votable.vote(users[0], 'minus')
      expect(votable.rating).to eq -1
    end
  end

  describe '#clear_vote' do
    it 'should cancel user vote' do
      votable.vote(users[0], 'plus')
      votable.clear_vote(users[0])
      expect(votable.rating).to eq 0
    end
  end

  describe '#voted?' do
    it 'returns true if user already voted' do
      votable.vote(users[0], 'up')
      expect(votable.voted?(users[0])).to be true
    end
    it 'returns false if user not voted yet' do
      expect(votable.voted?(users[0])).to be false
    end
  end
end