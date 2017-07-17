require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do
  sign_in_user
  let(:question) { create(:question) }
  let(:question_user) { create(:question, user: @user) }
  let(:answer) { create(:answer) }
  let(:answer_user) { create(:answer, question: question_user, user: @user) }

  describe 'DELETE #destroy' do
    before do
      attachment = File.open("#{Rails.root}/spec/spec_helper.rb")
      question.attachments.create(file: attachment)
      question_user.attachments.create(file: attachment)
      answer.attachments.create(file: attachment)
      answer_user.attachments.create(file: attachment)
    end

    context 'as an author' do
      it 'user is able to delete attachment from question', js: true do
        expect {
          delete :destroy, params: { id: question_user.attachments.first
          }, format: :js }.to change(Attachment, :count).by(-1)
      end

      it 'user is able to delete attachment from answer', js: true do
        expect {
          delete :destroy, params: { id: answer_user.attachments.first
          }, format: :js }.to change(Attachment, :count).by(-1)
      end
    end

    context 'as a non-author' do
      it 'user is trying to delete attachment from question', js: true do
        expect {
          delete :destroy, params: { id: question.attachments.first
          }, format: :js }.to_not change(Attachment, :count)
      end

      it 'user is trying to delete attachment from answer', js: true do
        expect {
          delete :destroy, params: { id: answer.attachments.first
          }, format: :js }.to_not change(Attachment, :count)
      end
    end

  end
end
