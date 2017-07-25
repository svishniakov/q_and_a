require_relative 'acceptance_helper'

feature 'Set best answer', %q{
  User have possibility to mark one of the answers as the best
} do

  given(:user) { create(:user) }
  given(:question_user) { create(:user) }
  given!(:question) { create :question, user: question_user, answers: create_list(:answer, 2) }

  context 'as an author of a question' do

    scenario 'best answer will be marked and placed on the top of the answer\'s table', js: true do
      sign_in(question_user)
      visit question_path(question)

      best_answer = question.answers.last

      within "#answer_#{best_answer.id}" do
        click_on 'Best?'
        expect(page).to have_css '.best'
      end

      within first("div#answers .questions-list-item") do
        expect(page).to have_content best_answer.body
      end
    end
  end

  context 'as a not an author of a question' do
    scenario 'user doesn\'t have possibility to check answer as the best' do
      sign_in(user)

      visit question_path(question)

      within '#answers' do
        expect(page).to_not have_link 'Mark as best'
      end
    end
  end
end