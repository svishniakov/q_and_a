require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question) { create(:question) }

  context 'as an anonymous user' do
    describe 'GET #index' do
      let(:questions) { create_list(:question, 2) }

      before { get :index }

      it 'populates an array of questions' do
        expect(assigns(:questions)).to match_array(questions)
      end

      it { is_expected.to render_template :index }
    end

    describe 'GET #show' do
      before {get :show, params: {id: question}}

      it 'sets requested question to @question' do
        expect(assigns(:question)).to eq question
      end

      it { is_expected.to render_template :show }
    end
  end

  context 'as a registered user' do
    sign_in_user
    let(:user_question) { create(:user_question, user_id: @user.id) }

    describe 'GET #new' do
      before { get :new }

      it 'sets new question to @question' do
        expect(assigns(:question)).to be_a_new(Question)
      end

      it 'creates new attachment object related to question' do
        expect(assigns(:question).attachments.first).to be_a_new(Attachment)
      end

      it { is_expected.to render_template :new }
    end

    describe 'GET #edit' do
      before { get :edit, params: { id: user_question } }

      it 'sets requested question to @question' do
        expect(assigns(:question)).to eq user_question
      end

      it { is_expected.to render_template :edit }
    end

    describe 'POST #create' do
      context 'using valid attributes' do
        it 'save new question to db' do
          expect { post :create, params: { question: attributes_for(:question) } }.to change(@user.questions, :count).by(1)
        end

        it 'redirects to show view' do
          post :create, params: { question: attributes_for(:question) }
          expect(response).to redirect_to question_path(assigns(:question))
        end
      end

      context 'using invalid attributes' do
        it 'failed to save question to db' do
          expect {post :create, params: { question: attributes_for(:invalid_question) } }.to_not change(Question, :count)
        end

        it 're-render new view' do
          post :create, params: { question: attributes_for(:invalid_question) }
          expect(response).to render_template :new
        end
      end
    end

    describe 'PATCH #update' do
      context 'using valid attributes' do
        it 'sets requested user_question to @question' do
          patch :update, params: { id: user_question, question: attributes_for(:user_question) }
          expect(assigns(:question)).to eq user_question
        end

        it 'updates question attributes' do
          patch :update, params: { id: user_question, question: {title: 'New title', body: 'New body' } }
          user_question.reload
          expect(user_question.title).to eq 'New title'
          expect(user_question.body).to eq 'New body'
        end

        it 'shows list with updated question' do
          patch :update, params: { id: user_question, question: attributes_for(:question) }
          expect(response).to redirect_to questions_path
        end
      end

      context 'using invalid attributes' do
        before { patch :update, params: { id: user_question, question: { title: 'New title', body: nil } } }
        it 'does not update question' do
          user_question.reload
          expect(user_question.title).to eq 'User question title'
          expect(user_question.body).to eq 'User question body'
        end

        it { is_expected.to render_template :edit }
      end
    end

    describe 'DELETE #destroy' do
      context 'author' do
        before { user_question }
        it 'is trying to delete his own question' do
          expect { delete :destroy, params: { id: user_question } }.to change(Question, :count).by(-1)
        end

        it 'redirects to index view' do
          delete :destroy, params: { id: user_question }
          expect(response).to redirect_to questions_path
        end
      end

      context 'non-author' do
        before { question }
        it 'is trying to delete not his answer' do
          expect { delete :destroy, params: { id: question } }.to_not change(Question, :count)
        end

        it 'and redirects to question show view' do
          delete :destroy, params: { id: question }
          expect(response).to redirect_to question_path(assigns(:question))
        end
      end

    end
  end
end
