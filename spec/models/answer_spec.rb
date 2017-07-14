require 'rails_helper'

RSpec.describe Answer, type: :model do
  context 'validations' do
    it { should validate_presence_of :body }
  end

  context 'relations' do
    it { should belong_to :question }
    it { should belong_to :user }
  end

  context 'methods ans scopes' do
    let(:question) { create :question_with_answers }
    let(:first_best_answer) { question.answers.first }
    let(:second_best_answer) { question.answers.second }
    let(:default_best_answer) { question.answers.last }

    describe 'best! method' do
      it 'sets first answer as a best' do
        first_best_answer.best!
        expect(first_best_answer).to be_best
      end

      it 'sets second answer as a best' do
        second_best_answer.best!
        expect(default_best_answer).to_not be_best
      end
    end

    describe '.best_first' do
      it 'should show best answer on the top of the list' do
        expect(question.answers.best_first.first).to eq default_best_answer
      end
    end
  end
end
