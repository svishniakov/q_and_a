require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }

  context 'as a registered user' do
    let(:current_user) { create(:user) }
    let(:user_answer) { create(:answer, question_id: question.id, user_id: current_user.id) }

    before do
      sign_in(current_user)
    end

    describe 'POST #create' do
      context 'using valid attributes' do
        it 'saves new answer to db' do
          expect { post :create, params: { answer: attributes_for(:answer),
                                           question_id: question }
            }.to change(question.answers, :count).by(1)
        end

        it 'related to logged-in user' do
          expect { post :create, params: { answer: attributes_for(:answer),
                                           question_id: question}
            }.to change(current_user.answers, :count).by(1)
        end

        it 'redirects to show view' do
          post :create, params: { answer: attributes_for(:answer),
                                  question_id: question }
          expect(response).to redirect_to question_path(assigns(:question))
        end
      end

      context 'using invalid attributes' do
        it 'failed to save answer to db' do
          expect { post :create, params: { answer: attributes_for(:invalid_answer),
                                           question_id: question }
            }.to_not change(Answer, :count)
        end

        it 're-render question page with answers' do
          post :create, params: { answer: attributes_for(:invalid_question),
                                  question_id: question }
          expect(response).to render_template 'questions/show'
        end
      end
    end

    describe 'PATCH #update' do
      context 'using valid attributes' do
        it 'sets requested answer to an @answer' do
          patch :update, params: { id: user_answer,
                                   answer: attributes_for(:answer),
                                   question_id: question,
                                   user_id: current_user }
          expect(assigns(:answer)).to eq user_answer
        end

        it 'updates answer attributes' do
          patch :update, params: {
            id: user_answer, answer: { body: 'New answer body',
                                       question_id: question,
                                       user_id: current_user } }
          user_answer.reload
          expect(user_answer.body).to eq 'New answer body'
        end

        it 'shows updated answer' do
          patch :update, params: { id: user_answer,
                                   answer: attributes_for(:answer),
                                   question_id: question,
                                   user_id: current_user }
          expect(response).to render_template 'questions/show'
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
      context 'author' do
        before { user_answer }
        it 'is trying to delete his own answer' do
          expect { delete :destroy, params: { id: user_answer, user_id: current_user } }.to change(question.answers, :count).by(-1)
        end

        it 'and redirects to question view' do
          delete :destroy, params: { id: user_answer, user_id: current_user }
          expect(response).to redirect_to question_path(assigns(:question))
        end
      end

      context 'non-author' do
        before { answer }
        it 'is trying to delete not his answer' do
          expect { delete :destroy, params: { id: user_answer, user_id: current_user } }.to_not change(Answer, :count)
        end

        it 'and redirects to question show view' do
          delete :destroy, params: { id: answer, user_id: current_user }
          expect(response).to redirect_to question_path(assigns(:question))
        end
      end
    end
  end
end
