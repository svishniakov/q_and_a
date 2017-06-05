require 'rails_helper'

RSpec.describe AnswerController, type: :controller do
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }

  describe 'GET #index' do
    let(:answers) { create_list(:answer, 2, question: question) }
    before { get :index, params: { question_id: question} }

    it 'sets answer question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'populates an array of answers' do
      expect(assigns(:answers)).to match_array(answers)
    end

    it { should render_template :index }
  end
end
