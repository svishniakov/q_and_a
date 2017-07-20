require 'rails_helper'

shared_examples_for 'voted' do

  voted_klass = described_class.controller_name.singularize.to_sym
  sign_in_user
  let(:voted) { create(voted_klass) }
  let(:author_voted) { create(voted_klass, user: @user) }

  describe 'PATCH #plus' do
    context 'as nonauthor of an answer' do
      it 'rating increate' do
        expect { patch :plus, params: { id: voted }, format: :js }.to change(voted, :rating).by(1)
      end
      it 'avoid to vote more than once' do
        patch :plus, params: { id: voted }, format: :js
        expect { patch :plus, params: { id: voted }, format: :js }.to_not change(voted, :rating)
      end
    end

    context 'as an answer\'s author' do
      it 'avoid to vote' do
        expect { patch :plus, params: { id: author_voted }, format: :js }.to_not change(author_voted, :rating)
      end
    end
  end
  describe 'PATCH #minus' do
    context 'as nonauthor of an answer' do
      it 'rating decrease' do
        expect { patch :minus, params: { id: voted }, format: :js }.to change(voted, :rating).by(-1)
      end
      it 'avoid to vote mre than twice' do
        patch :minus, params: { id: voted }, format: :js
        expect { patch :minus, params: { id: voted }, format: :js }.to_not change(voted, :rating)
      end
    end

    context 'as an answer\'s author' do
      it 'avoid to vote' do
        expect { patch :minus, params: { id: author_voted }, format: :js }.to_not change(author_voted, :rating)
      end
    end
  end
  describe 'PATCH #clear_vote' do
    context 'user cancels his vote' do
      it 'change rating via vote remove' do
        patch :minus, params: { id: voted }, format: :js
        delete :clear_vote, params: { id: voted }, format: :js
        voted.reload
        expect(voted.rating).to eq 0
      end
    end
  end
end