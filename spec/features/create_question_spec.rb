require 'rails_helper'

feature 'Create question', %q{
Logged in user must have possibility to create a questions
} do

  given(:user) { create(:user) }

  context 'using valid attributes' do
    let(:question) { create(:question) }
    scenario 'Logged in user needs to have possibility to create question' do
      sign_in(user)

      click_on 'Ask question'
      fill_in 'Title', with: question.title
      fill_in 'Body', with: question.body
      click_on 'Save question'

      expect(page).to have_content question.title
      expect(page).to have_content question.body
    end
  end

  context 'using invalid attributes' do
    scenario 'Logged in user is trying to create a question' do
      sign_in(user)

      click_on 'Ask question'
      fill_in 'Title', with: nil
      fill_in 'Body', with: nil
      click_on 'Save question'

      expect(page).to have_content 'There are few errors prohibited this form from being saved'
    end
  end
end