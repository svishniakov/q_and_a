require 'rails_helper'

feature 'Delete permissions', %q{
Logged in user has to be able to delete his own question
} do

  given(:user) { create(:user) }
  given(:user_answer) { create(:user_two) }

  context 'User not an author' do
    let(:question) { create(:question, user: user) }
    let(:answer) { create(:answer, question: question, user: user) }
    scenario 'User can not delete a question where he is not an author' do
      sign_in(user_answer)
      visit question_path(question)
      expect(page).to_not have_link 'Delete question'
    end

    scenario 'User can not delete an answer where he is not an author' do
      sign_in(user_answer)
      visit question_path(question)
      expect(page).to_not have_link 'Delete answer'
    end
  end

  context 'User as an author' do
    let(:question) { create(:question, user: user) }
    let(:answer) { create(:answer, question: question, user: user) }
    scenario 'User can delete only his own question' do
      sign_in(user)
      visit question_path(question)
      expect(page).to have_link 'Delete question'
    end

    scenario 'User can delete an answer where he is not an author' do
      sign_in(user)
      visit question_path(question)
      question.answers.each do
        expect(page).to have_link 'Delete answer'
      end
    end
  end
end