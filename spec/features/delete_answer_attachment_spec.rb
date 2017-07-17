require_relative 'acceptance_helper'

feature 'Possibility to delete attachment from an answer' do
  given(:user) { create :user }
  given(:question) { create :question, user: user }
  given(:answer) { create :answer, user: user, question: question }
  given(:attachment) { File.open("#{Rails.root}/spec/rails_helper.rb") }
  given(:nonauthor_user) { create :user }

  context 'as an author of an answer' do
    scenario 'is able to delete attachment from his own answers', js: true do
      sign_in(user)
      answer.attachments.create(file: attachment)
      visit question_path(question)

      within '#answers' do
        click_on 'Delete'
        expect(page).to_not have_link 'rails_helper.rb'
      end
    end
  end

  context 'as nonauthor of an answer' do
    scenario 'is unable to access attachment delete feature' do
      sign_in(nonauthor_user)
      answer.attachments.create(file: attachment)
      visit question_path(question)

      within '#answers' do
        expect(page).to_not have_link 'Delete'
      end
    end
  end
end
