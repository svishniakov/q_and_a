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

    it { is_expected.to render_template :index }
  end

  describe 'GET #show' do
    before { get :show, params: { id: answer, question_id: question } }

    it 'sets requested answer to @answer' do
      expect(assigns(:answer)).to eq answer
    end

    it { is_expected.to render_template :show }
  end

  describe 'GET #new' do
    before { get :new, params: { question_id: question } }

    it 'sets answer question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'sets new answer to @answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it { is_expected.to render_template :new }
  end

  describe 'GET #edit' do
    before { get :edit, params: { id: answer, question_id: question } }

    it 'sets requested answer to @answer' do
      expect(assigns(:answer)).to eq answer
    end

    it { is_expected.to render_template :edit }
  end

  describe 'POST #create' do
    context 'using valid attributes' do
      it 'saves new answer to db' do
        expect { post :create, params: { answer: attributes_for(:answer), question_id: question } }.to change(question.answers, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: { answer: attributes_for(:answer), question_id: question }
        expect(response).to redirect_to answer_path(assigns(:answer))
      end
    end

    context 'using invalid attributes' do
      it 'failed to save answer to db' do
        expect { post :create, params: { answer: attributes_for(:invalid_answer), question_id: question } }.to_not change(Answer, :count)
      end

      it 're-render new view' do
        post :create, params: { answer: attributes_for(:invalid_question), question_id: question }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    context 'using valid attributes' do
      it 'sets requested answer to an @answer' do
        patch :update, params: { id: answer, answer: attributes_for(:answer), question_id: question }
        expect(assigns(:answer)).to eq answer
      end

      it 'updates answer attributes' do
        patch :update, params: { id: answer, answer: { body: 'New answer body', question_id: question } }
        answer.reload
        expect(answer.body).to eq 'New answer body'
      end

      it 'shows updated answer' do
        patch :update, params: { id: answer, answer: attributes_for(:answer), question_id: question }
        expect(response).to redirect_to answer_path(assigns(:answer))
      end
    end

    context 'using invalid attributes' do
      before { patch :update, params: { id: answer, answer: { body: nil }, question_id: question } }
      it 'does not update answer' do
        answer.reload
        expect(answer.body).to eq 'Valid answer body'
      end

      it { is_expected.to render_template :edit }
    end
  end

  describe 'DELETE #destroy' do
    before { answer }

    it 'answer destroy' do
      expect { delete :destroy, params: { id: answer } }.to change(Answer, :count).by(-1)
    end

    it 'redirects to index view' do
      delete :destroy, params: { id: answer }
      expect(response).to redirect_to questions_path
    end
  end
end
