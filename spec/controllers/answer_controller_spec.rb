require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }

  context 'as a registered user' do
    sign_in_user
    let(:user_answer) { create(:answer, question_id: question.id, user: @user) }

    describe 'POST #create' do
      context 'using valid attributes' do
        it 'saves new answer to db' do
          expect { post :create, params: { answer: attributes_for(:answer),
                                           question_id: question, format: :js }
            }.to change(question.answers, :count).by(1)
        end

        it 'related to logged-in user' do
          expect { post :create, params: { answer: attributes_for(:answer),
                                           question_id: question, format: :js }
            }.to change(@user.answers, :count).by(1)
        end

        it 'redirects to show view' do
          post :create, params: { answer: attributes_for(:answer),
                                  question_id: question, format: :js }
          expect(response).to render_template :create
        end
      end

      context 'using invalid attributes' do
        it 'failed to save answer to db' do
          expect { post :create, params: { answer: attributes_for(:invalid_answer),
                                           question_id: question, format: :js }
            }.to_not change(Answer, :count)
        end

        it 'render answers create form' do
          post :create, params: { answer: attributes_for(:invalid_question),
                                  question_id: question, format: :js }
          expect(response).to render_template :create
        end
      end
    end

    describe 'PATCH #update' do
      context 'using valid attributes' do
        it 'sets requested answer to an @answer' do
          patch :update, params: { id: user_answer,
                                   answer: attributes_for(:answer),
                                   question_id: question, format: :js }
          expect(assigns(:answer)).to eq user_answer
        end

        it 'updates answer attributes' do
          patch :update, params: {
            id: user_answer, answer: { body: 'New answer body',
                                       question_id: question }, format: :js }
          user_answer.reload
          expect(user_answer.body).to eq 'New answer body'
        end

        it 'shows updated answer' do
          patch :update, params: { id: user_answer,
                                   answer: attributes_for(:answer),
                                   question_id: question, format: :js }
          expect(response).to render_template :update
        end
      end

      context 'using invalid attributes' do
        before { patch :update, params: { id: answer, answer: { body: nil }, question_id: question } }
        it 'does not update answer' do
          answer.reload
          expect(answer.body).to eq answer.body
        end

        it { is_expected.to redirect_to question_path(question) }
      end
    end

    describe 'DELETE #destroy' do
      context 'author' do
        before { user_answer }
        it 'is trying to delete his own answer' do
          expect { delete :destroy, params: { id: user_answer }, format: :js }.to change(Answer, :count).by(-1)
        end

        it 'and redirects to question view' do
          delete :destroy, params: { id: user_answer }
          expect(response).to redirect_to question_path(assigns(:question))
        end
      end

      context 'non-author' do
        before { answer }
        it 'is trying to delete not his answer' do
          expect { delete :destroy, params: { id: user_answer } }.to_not change(Answer, :count)
        end

        it 'and redirects to question show view' do
          delete :destroy, params: { id: answer }
          expect(response).to redirect_to question_path(assigns(:question))
        end
      end
    end

    describe 'PATCH #best' do
      sign_in_user
      let(:question) { create :question, answers: create_list(:answer, 2) }
      let(:question_user) { create :question, answers: create_list(:answer, 2), user: @user }

      context 'as a question author' do
        it 'set best answer from the list of available answers' do
          patch :best, params: { id: question.answers.first }, format: :js
          expect(assigns(:answer).best!).to eq true
        end
      end
    end
  end
end
