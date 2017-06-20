require 'rails_helper'

feature 'Ask question form', %q{
Logged in user needs to have possibility to access Ask question form
} do

  given(:user) { create(:user) }

  scenario 'Registered user is trying to access Ask question form' do
    sign_in(user)
    visit root_path
    click_on 'Ask question'
    expect(current_path).to eq new_question_path
  end


  scenario 'Anonymous user is trying to access Ask question form' do
    visit root_path
    expect(page).to_not have_link 'Ask question'
  end
end