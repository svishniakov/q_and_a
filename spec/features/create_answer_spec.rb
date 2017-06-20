require 'rails_helper'

feature 'Post an answer' do

  given(:user) {create(:user)}
  given(:question) {create(:question)}


  context 'as a registered user' do
    before do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'using valid attributes' do
      fill_in 'answer_body', with: 'My new answer!'
      click_on 'Post answer'
      expect(page).to have_content 'My new answer!'
    end

    scenario 'using invalid attributes' do
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
end