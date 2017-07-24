require_relative 'acceptance_helper'

feature 'Question rating', js: true do

  given!(:user) { create(:user) }
  given!(:question_user) { create(:user) }
  given!(:question) { create :question, user: question_user }

  context 'As nonauthor of a question' do
    before do
      sign_in(user)
      visit root_path
    end

    scenario 'user can vote for a question' do
      within "#question_#{question.id}" do
        click_on '+'
        expect(page).to have_content '1'
      end
    end

    scenario 'user have no possibility to vote more than once' do
      within "#question_#{question.id}" do
        expect(page).to_not have_link '+'
        expect(page).to_not have_link '-'
      end
    end

    scenario 'user have possibility to clear his vote' do
      within "#question_#{question.id}" do
        click_on '+'
        click_on 'C'
        expect(page).to have_content '0'
      end
    end

    scenario 'user can devote a question' do
      within "#question_#{question.id}" do
        click_on '-'
        expect(page).to have_content '-1'
      end
    end
  end

  context 'as an author of a question' do
    scenario 'user have no access to voting links', js: true do
      sign_in(question_user)
      visit root_path

      within "#question_#{question.id}" do
        expect(page).to_not have_link '+'
        expect(page).to_not have_link '-'
        expect(page).to_not have_link 'C'
      end
    end
  end
end