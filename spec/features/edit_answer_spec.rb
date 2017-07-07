require_relative 'acceptance_helper'

feature 'Edit answer', %q{
  User should be able to edit his own answer
} do

  given(:user) { create(:user) }
  given(:user_with_no_answers) { create(:user) }
  given(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question, user: user) }

  context 'as a registered user' do
    scenario 'Logged in user is trying to edit his own answer', js: true do
      sign_in(user)
      visit question_path(question)

      within '#answers' do
        expect(page).to have_link 'Edit answer'
        click_on 'Edit answer'
        fill_in 'Edit answer', with: 'Edited answer'
        click_on 'Save'

        expect(page).to_not have_content answer.body
        expect(page).to have_content 'Edited answer'
        expect(page).to_not have_selector 'textarea'
      end
    end

    scenario 'Logged in user is trying to edit an answer created by someone else' do
      sign_in(user_with_no_answers)
      visit question_path(question)

      within '#answers' do
        expect(page).to_not have_link 'Edit answer'
      end
    end
  end

  context 'as an anonymous user' do
    scenario 'Anonymous user is trying to edit answer' do
      visit question_path(question)
      expect(page).to_not have_link 'Edit answer'
    end
  end

end