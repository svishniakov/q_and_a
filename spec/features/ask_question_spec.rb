require 'rails_helper'

feature 'Ask question', %q{
Logged in user needs to have possibility to ask questions
} do

  given(:user) { create(:user) }

  scenario 'Registered user is trying to access Add question form' do
    sign_in(user)

    visit root_path
    click_on 'Ask question'
    expect(current_path).to eq new_question_path
  end


  scenario 'Anonymous user is trying to access Add question form' do
    visit root_path
    click_on 'Ask question'
    expect(page).to have_content 'You need to sign in or sign up before continuing'
  end
end