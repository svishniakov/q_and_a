require_relative 'acceptance_helper'

feature 'Possibility to delete question' do

  given!(:user) { create(:user) }
  given!(:answer_user) { create(:user) }
  given!(:question) { create(:question, user: user) }

  context 'when the logged in user as not an author' do
    scenario 'is not able to access question delete link' do
      sign_in(answer_user)
      visit question_path(question)
      expect(page).to_not have_link 'Delete question'
    end
  end

  context 'when the logged in user as an author' do
    before do
      sign_in(user)
    end

    scenario 'is able to delete question on index page' do
      visit questions_path
      within("div#del_question_#{question.id}") do
        click_on 'Delete'
        expect(page).to_not have_content question.title
      end
    end

    scenario 'is able to delete question question on show page' do
      visit question_path(question)
      click_on 'Delete question'
      expect(page).to have_content 'Question successfully deleted'
    end
  end
end