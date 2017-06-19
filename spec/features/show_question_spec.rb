require 'rails_helper'

feature 'Visit question show page' do

  given(:question) { create(:question) }
  given(:user) { create(:user) }

  scenario 'Anonymous user needs to have possibility to open question page' do
    show_question
  end

  scenario 'Registered user needs to have possibility to open question page' do
    sign_in(user)
    show_question
  end

  private

  def show_question
    visit question_path(question)
    expect(page).to have_content question.title
    expect(page).to have_content question.body
  end
end