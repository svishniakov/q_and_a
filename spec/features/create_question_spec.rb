require 'rails_helper'

feature 'Post a question' do

  given(:user) { create(:user) }

  context 'as a registered user' do
    let(:question) { create(:question) }
    before do
      sign_in(user)
      click_on 'Ask question'
    end

    scenario 'using valid attributes' do
      fill_in 'Title', with: question.title
      fill_in 'Body', with: question.body
      click_on 'Save question'
      expect(page).to have_content question.title
      expect(page).to have_content question.body
    end

    scenario 'using invalid attributes' do
      fill_in 'Title', with: nil
      fill_in 'Body', with: nil
      click_on 'Save question'
      expect(page).to have_content 'There are few errors prohibited this form from being saved'
    end
  end


  scenario 'as an anonymous user using Ask question form' do
    visit root_path
    expect(page).to_not have_link 'Ask question'
  end
end