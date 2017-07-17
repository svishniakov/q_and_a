require 'rails_helper'

RSpec.describe Answer, type: :model do

  shared_context 'answer_helpers' do
    let(:question) { create :question_with_answers }
    let(:first_answer) { question.answers.first }
    let(:second_answer) { question.answers.second }
    let(:default_best_answer) { question.answers.last }
  end

  context 'validations' do
    it { should validate_presence_of :body }
  end

  context 'relations' do
    it { should belong_to :question }
    it { should belong_to :user }
  end

  context 'methods' do
    include_context 'answer_helpers'
    describe '#best!' do
      it 'sets first answer as a best' do
        first_answer.best!
        expect(first_answer).to be_best
      end

      it 'sets second answer as a best' do
        second_answer.best!
        expect(default_best_answer).to_not be_best
      end
    end
  end

  context 'scopes' do
    include_context 'answer_helpers'
    describe '.best_first' do
      it 'should show best answer on the top of the list' do
        expect(question.answers.best_first.first).to eq default_best_answer
      end
    end
  end
end
