require 'rails_helper'

feature 'Post answer', %q{
Registered and logged in user has to be able to post answer to the question
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Post an answer as a registered user' do
    sign_in(user)
    visit question_path(question)

    expect(page).to have_content question.title
    expect(page).to have_content question.body
    expect(page).to have_field('answer_body')

    fill_in 'answer_body', with: 'My new answer!'
    click_on 'Post answer'
    expect(page).to have_content 'My new answer!'
  end

  scenario 'Post an answer as an anonymous user' do
    visit question_path(question)
    expect(page).to_not have_field('answer_body')
  end
end