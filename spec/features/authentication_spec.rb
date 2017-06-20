require 'rails_helper'

feature 'User authentication', %q{
  User needs to have possibility to:
  Register
  Login
  Logout
} do

  given(:user) { create(:user) }

  scenario 'User needs to have possibility to register' do
    visit new_user_registration_path
    fill_in 'Email', with: 'registration@test.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_button 'Sign up'
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  scenario 'Registered user needs to have possibility to login' do
    sign_in(user)
    expect(page).to have_content 'Signed in successfully'
    expect(current_path).to eq root_path
  end

  scenario 'Registered user needs to have possibility to Logout' do
    sign_in(user)
    click_on 'Log out'
    expect(page).to have_content 'Signed out successfully.'
    expect(current_path).to eq root_path
  end

  scenario 'Not registered user is trying to sign in' do
    visit new_user_session_path
    fill_in 'Email', with: 'wrong_user@test.com'
    fill_in 'Password', with: 'wrong_pass'
    click_button 'Log in'
    expect(page).to have_content 'Invalid Email or password'
    expect(current_path).to eq new_user_session_path
  end
end