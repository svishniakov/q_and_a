require 'rails_helper'

feature 'Check delete permissions' do

  given(:user) { create(:user) }
  given(:answer_user) { create(:answer_user) }

  context 'Logged in user as not an author' do
    let(:question) { create(:question, user: user) }
    let(:answer) { create(:answer, question: question, user: user) }
    scenario 'is not able to delete a question where he is not an author' do
      sign_in(answer_user)
      visit question_path(question)
      expect(page).to_not have_link 'Delete question'
    end

    scenario 'is not able to delete an answer where he is not an author' do
      sign_in(answer_user)
      visit question_path(question)
      expect(page).to_not have_link 'Delete answer'
    end
  end

  context 'Logged in user as an author' do
    let(:question) { create(:question, user: user) }
    let(:answer) { create(:answer, question: question, user: user) }
    scenario 'is able to delete only his own question' do
      question
      sign_in(user)
      visit questions_path
      within("div#del_question_#{question.id}") do
        expect(page).to have_link 'Delete'
      end
    end

    scenario 'is able to delete only his own answer' do
      answer
      sign_in(user)
      visit question_path(question)
      within("div#del_answer_#{answer.id}") do
        expect(page).to have_link 'Delete answer'
      end
    end
  end
end