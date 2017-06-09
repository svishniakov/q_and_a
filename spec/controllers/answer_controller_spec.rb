require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }

  context 'as an anonymous user' do
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
  end

  context 'as a registered user' do
    let(:current_user) { create(:user) }
    let(:user_answer) { create(:answer, question: question, user_id: current_user.id) }

    before do
      sign_in(current_user)
      allow(controller).to receive(:current_user).and_return current_user
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
      before { get :edit, params: { id: user_answer, question_id: question, user_id: current_user } }

      it 'sets requested user_answer to @answer' do
        expect(assigns(:answer)).to eq user_answer
      end

      it { is_expected.to render_template :edit }
    end

    describe 'POST #create' do
      context 'using valid attributes' do
        it 'saves new answer to db' do
          expect { post :create, params: { answer: attributes_for(:answer), question_id: question, user_id: current_user } }.to change(question.answers, :count)
        end

        it 'redirects to show view' do
          post :create, params: { answer: attributes_for(:answer), question_id: question, user_id: current_user }
          expect(response).to redirect_to question_path(assigns(:question))
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
          patch :update, params: { id: user_answer, answer: attributes_for(:answer), question_id: question, user_id: current_user }
          expect(assigns(:answer)).to eq user_answer
        end

        it 'updates answer attributes' do
          patch :update, params: { id: user_answer, answer: { body: 'New answer body', question_id: question, user_id: current_user } }
          user_answer.reload
          expect(user_answer.body).to eq 'New answer body'
        end

        it 'shows updated answer' do
          patch :update, params: { id: user_answer, answer: attributes_for(:answer), question_id: question, user_id: current_user }
          expect(response).to redirect_to answer_path(assigns(:answer))
        end
      end

      context 'using invalid attributes' do
        before { patch :update, params: { id: answer, answer: { body: nil }, question_id: question } }
        it 'does not update answer' do
          answer.reload
          expect(answer.body).to eq 'Valid answer body'
        end

        it { is_expected.to redirect_to question_path(question) }
      end
    end

    describe 'DELETE #destroy' do
      before { user_answer }

      it 'answer destroy' do
        expect { delete :destroy, params: { id: user_answer, user_id: current_user } }.to change(Answer, :count).by(-1)
      end

      it 'redirects to index view' do
        delete :destroy, params: { id: user_answer, user_id: current_user }
        expect(response).to redirect_to questions_path
      end
    end
  end
end
