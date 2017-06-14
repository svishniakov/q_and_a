require 'rails_helper'

feature 'Delete permissions', %q{
Logged in user has to be able to delete his own question
} do

  given(:user) { create(:user) }
  given(:answer_user) { create(:answer_user) }

  context 'User not an author' do
    let(:question) { create(:question, user: user) }
    let(:answer) { create(:answer, question: question, user: user) }
    scenario 'User can not delete a question where he is not an author' do
      sign_in(answer_user)
      visit question_path(question)
      expect(page).to_not have_link 'Delete question'
    end

    scenario 'User can not delete an answer where he is not an author' do
      sign_in(answer_user)
      visit question_path(question)
      expect(page).to_not have_link 'Delete answer'
    end
  end

  context 'User as an author' do

    before do
      @answer_id = answer.id
    end

    let(:question) { create(:question, user: user) }
    let(:answer) { create(:answer, question: question, user: user) }
    scenario 'User can delete only his own question' do
      sign_in(user)
      visit question_path(question)
      within("div#del_answer_#{@answer_id}") do
        expect(page).to_not have_link 'Delete answer'
      end
    end

    scenario 'User can delete an answer where he is an author' do
      sign_in(user)
      visit question_path(question)
      within("div#del_answer_#{@answer_id}") do
        expect(page).to have_link 'Delete answer'
      end
    end
  end
end