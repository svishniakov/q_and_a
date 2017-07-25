require_relative 'acceptance_helper'

feature 'Create an answer' do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }

  context 'as a registered user' do
    before do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'using valid attributes', js: true do
      fill_in 'answer_body', with: 'My new answer!'
      click_on 'Post answer'

      expect(current_path).to eq question_path(question)
      within '#answers' do
        expect(page).to have_content 'My new answer!'
      end
    end

    scenario 'using invalid attributes', js: true do
      fill_in 'answer_body', with: nil
      click_on 'Post answer'
      expect(page).to have_content 'Body can\'t be blank'
    end
  end

  context 'as an anonymous user' do
    scenario 'Post an answer as an anonymous user' do
      visit question_path(question)
      expect(page).to_not have_link 'Post answer'
    end
  end

  context 'multiple sessions' do
    scenario 'answer appears on another\'s user page', js: true do
      Capybara.using_session('user') do
        sign_in(user)
        visit question_path(question)
      end

      Capybara.using_session('guest') do
        visit question_path(question)
      end

      Capybara.using_session('user') do
        fill_in 'answer_body', with: 'My new answer!'
        click_on 'Post answer'

        expect(current_path).to eq question_path(question)
        within '#answers' do
          expect(page).to have_content 'My new answer!'
        end
      end

      Capybara.using_session('guest') do
        within '#answers' do
          expect(page).to have_content 'My new answer!'
        end
      end
    end
  end
end