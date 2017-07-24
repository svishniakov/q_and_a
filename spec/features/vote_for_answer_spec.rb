require_relative 'acceptance_helper'

feature 'Answer rating' do

  given!(:user) { create(:user) }
  given!(:answer_user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create :answer, question: question, user: answer_user }

  context 'As nonauthor of an answer' do
    before do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'user can vote for an answer', js: true do
      vote_answer = question.answers.first
      within "#answer_#{vote_answer.id}" do
        click_on '+'
        expect(page).to have_content '1'
      end
    end

    scenario 'user have possibility to clear his vote', js: true do
      vote_answer = question.answers.first
      within "#answer_#{vote_answer.id}" do
        click_on '+'
        click_on 'C'
        expect(page).to have_content '0'
      end
    end

    scenario 'user have no possibility to vote more than once', js: true do
      vote_answer = question.answers.first
      within "#answer_#{vote_answer.id}" do
        click_on '+'
        click_on '-'
        expect(page).to have_content 'You can vote only once'
      end
    end

    scenario 'user can devote an answer', js: true do
      vote_answer = question.answers.first
      within "#answer_#{vote_answer.id}" do
        click_on '-'
        expect(page).to have_content '-1'
      end
    end
  end

  context 'as an author of an answer' do
    scenario 'user have no access to voting links', js: true do
      sign_in(answer_user)
      visit question_path(question)

      vote_answer = question.answers.last

      within "#answer_#{vote_answer.id}" do
        expect(page).to_not have_link '+'
        expect(page).to_not have_link '-'
        expect(page).to_not have_link 'C'
      end
    end
  end
end