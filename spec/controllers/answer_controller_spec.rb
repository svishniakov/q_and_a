require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }

  describe 'GET #index' do
    let(:answers) { create_list(:answer, 2, question: question) }
    before { get :index, params: { question_id: question } }

    it 'sets answer question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'populates an array of answers' do
      expect(assigns(:answers)).to match_array(answers)
    end

    it { should render_template :index }
  end

  describe 'GET #show' do
    before { get :show, params: { id: answer, question_id: question } }

    it 'sets requested answer to @answer' do
      expect(assigns(:answer)).to eq answer
    end

    it { should render_template :show }
  end

  describe 'GET #new' do
    before { get :new, params: { question_id: question } }

    it 'sets answer question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'sets new answer to @answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it { should render_template :new }
  end

  describe 'GET #edit' do
    before { get :edit, params: { id: answer, question_id: question } }

    it 'sets requested answer to @answer' do
      expect(assigns(:answer)).to eq answer
    end

    it { should render_template :edit }
  end

  describe 'POST #create' do
    context 'using valid attributes' do
      it 'saves new answer to db' do
        expect { post :create, params: { answer: attributes_for(:answer), question_id: question } }.to change(Answer, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: { answer: attributes_for(:answer), question_id: question }
        should redirect_to answer_path(assigns(:answer))
      end
    end

    context 'using invalid attributes' do
      it 'failed to save answer to db' do
        expect { post :create, params: { answer: attributes_for(:invalid_answer), question_id: question } }.to_not change(Answer, :count)
      end

      it 're-render new view' do
        post :create, params: { answer: attributes_for(:invalid_question), question_id: question }
        should render_template :new
      end
    end
  end
end
