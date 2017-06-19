require 'rails_helper'

feature 'Possibility to delete answer' do

  given!(:user) { create(:user) }
  given!(:answer_user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }

  context 'when the logged in user not an author' do
    scenario 'is not able to delete an answer where he is not an author' do
      sign_in(answer_user)
      visit question_path(question)
      expect(page).to_not have_link 'Delete answer'
    end
  end

  context 'when the logged in user is an author' do
    before do
      answer
      sign_in(user)
      visit question_path(question)
    end

    scenario 'is able to delete answer' do
      within("div#del_answer_#{answer.id}") do
        click_on 'Delete answer'
        expect(page).to_not have_content answer.body
      end
    end

    scenario 'and see notification' do
      click_on 'Delete answer'
      expect(page).to have_content 'Answer successfully deleted'
    end
  end
end