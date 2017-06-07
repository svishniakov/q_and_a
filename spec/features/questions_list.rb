require 'rails_helper'

feature 'Questions list', %q{
Site visitor needs to have possibility to see all the questions
} do

  given(:user) { create(:user) }

  scenario 'Registered user is trying to access list with all the questions' do
    sign_in(user)
    visit root_path

    expect(page).to have_content 'All questions'
    expect(current_path).to eq questions_path
  end

  scenario 'Not registered user is trying to access list with all the questions' do
    visit root_path

    expect(page).to have_content 'All questions'
    expect(current_path).to eq questions_path
  end
end