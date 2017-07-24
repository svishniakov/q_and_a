require_relative 'acceptance_helper'

feature 'Post a question', js: true do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  context 'as a registered user' do
    before do
      sign_in(user)
      click_on 'Ask question'
    end

    scenario 'using valid attributes' do
      fill_in 'Title', with: question.title
      fill_in 'Body', with: question.body
      click_on 'Save question'
      expect(page).to have_content question.title
    end

    scenario 'using invalid attributes' do
      fill_in 'Title', with: nil
      fill_in 'Body', with: nil
      click_on 'Save question'
      expect(page).to have_content 'Title can\'t be blank'
      expect(page).to have_content 'Body can\'t be blank'
    end
  end


  context 'as an anonymous user' do
    scenario 'as an anonymous user using Ask question form' do
      visit root_path
      expect(page).to_not have_link 'Ask question'
    end
  end

  context 'multiple sessions' do
    scenario 'question appears on another\'s user page' do
      Capybara.using_session('user') do
        sign_in(user)
        visit root_path
      end

      Capybara.using_session('guest') do
        visit questions_path
      end

      Capybara.using_session('user') do
        click_on 'Ask question'

        fill_in 'Title', with: question.title
        fill_in 'Body', with: question.body
        click_on 'Save question'

        expect(page).to have_content question.title
      end

      Capybara.using_session('guest') do
        expect(page).to have_content question.title
      end
    end
  end
end