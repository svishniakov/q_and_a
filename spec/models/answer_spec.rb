require 'rails_helper'

RSpec.describe Answer, type: :model do
  context 'validations' do
    it { should validate_presence_of :body }
  end

  context 'relations' do
    it { should belong_to :question }
    it { should belong_to :user }
  end

  let(:question) { create :question, answers: create_list(:answer, 2) }
  let(:first_best_answer) { question.answers.first }
  let(:last_best_answer) { question.answers.last }

  describe 'best! method' do
    before { first_best_answer.best! }

    it 'sets first answer as a best' do
      first_best_answer.reload
      expect(first_best_answer.best).to be true
    end

    it 'sets last answer as a best' do
      last_best_answer.best!
      last_best_answer.reload
      expect(last_best_answer.best).to be true
    end

    it 'should show best answer on the top of the list' do
      last_best_answer.best!
      expect(question.answers.best.first).to eq last_best_answer
    end
  end
end
