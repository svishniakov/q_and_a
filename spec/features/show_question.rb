require 'rails_helper'

feature 'Visit question show page' do

  given(:question) { create(:question) }
  given(:user) { create(:user) }

  scenario 'Anonymous user needs to have possibility to open question page' do
    visit question_path(question)
    expect(page).to have_content 'Valid question title'
    expect(page).to have_content 'Valid question body'
  end

  scenario 'Registered user needs to have possibility to open question page' do
    sign_in(user)
    visit question_path(question)
    expect(page).to have_content 'Valid question title'
    expect(page).to have_content 'Valid question body'
  end

end