require 'rails_helper'

feature 'User sign in', %q{
User needs to be logged in to be able to ask questions
} do

  given(:user) { create(:user) }

  scenario 'Registered user is trying to sign in' do
    sign_in(user)

    expect(page).to have_content 'Signed in successfully'
    expect(current_path).to eq root_path
  end

  scenario 'Not registered user is trying to sign in' do
    visit new_user_session_path
    fill_in 'Email', with: 'wrong_user@test.com'
    fill_in 'Password', with: 'wrong_pass'
    click_on 'Log in'

    expect(page).to have_content 'Invalid Email or password'
    expect(current_path).to eq new_user_session_path
  end
end