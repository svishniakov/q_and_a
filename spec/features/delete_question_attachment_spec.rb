require_relative 'acceptance_helper'

feature 'Possibility to delete attachments from question' do
  given(:user) { create :user }
  given(:question) { create :question, user: user }
  given(:attachment) { File.open("#{Rails.root}/spec/rails_helper.rb") }
  given(:nonauthor_user) { create :user }

  context 'as an author of a question' do
    scenario 'author have possibility to delete attachment from his own question', js: true do
      sign_in(user)
      question.attachments.create(file: attachment)
      visit question_path(question)

      within 'ul#attachments' do
        click_on 'Delete'
        expect(page).to_not have_link 'rails_helper.rb'
      end
    end
  end

  context 'as nonauthor of a question' do
    scenario 'non author is trying to access attachment delete functionality', js: true do
      sign_in(nonauthor_user)
      question.attachments.create(file: attachment)
      visit question_path(question)

      within 'ul#attachments' do
        expect(page).to_not have_link 'Delete'
      end

    end
  end
end