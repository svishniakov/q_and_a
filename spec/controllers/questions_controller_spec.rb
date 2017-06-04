require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question) { create(:question) }

  describe 'GET #index' do
    let(:questions) { create_list(:question, 2) }

    before { get :index }

    it 'populates an array of questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it { should render_template :index }
  end

  describe 'GET #show' do
    let(:question) { create(:question) }

    before { get :show, params: { id: question } }

    it 'sets requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it { should render_template :show }
  end

  describe 'GET #new' do
    before { get :new }

    it 'sets new question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it { should render_template :new }
  end

  describe 'GET #edit' do
    before { get :edit, params: { id: question } }

    it 'sets requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it { should render_template :edit }
  end

  describe 'POST #create' do
    context 'using valid attributes' do
      it 'save new question to db' do
        expect { post :create, params: { question: attributes_for(:question) } }.to change(Question, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: { question: attributes_for(:question) }
        should redirect_to question_path(assigns(:question))
      end
    end

    context 'using invalid attributes' do
      it 'failed to save question to db' do
        expect { post :create, params: { question: attributes_for(:invalid_question) } }.to_not change(Question, :count)
      end

      it 're-render new view' do
        post :create, params: { question: attributes_for(:invalid_question) }
        should render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    context 'using valid attributes' do
      it 'sets requested question to @question' do
        patch :update, params: { id: question, question: attributes_for(:question) }
        expect(assigns(:question)).to eq question
      end

      it 'updates question attributes' do
        patch :update, params: { id: question, question: { title: 'New title', body: 'New body'} }
        question.reload
        expect(question.title).to eq 'New title'
        expect(question.body).to eq 'New body'
      end

      it 'shows updated question' do
        patch :update, params: { id: question, question: attributes_for(:question) }
        should redirect_to question_path(assigns(:question))
      end
    end

    context 'using invalid attributes' do
      before { patch :update, params: { id: question, question: { title: 'New title', body: nil } } }
      it 'does not update question' do
        question.reload
        expect(question.title).to eq 'Valid question title'
        expect(question.body).to eq 'Valid question body'
      end

      it { should render_template :edit }
    end
  end
end
