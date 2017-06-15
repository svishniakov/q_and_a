require 'rails_helper'

feature 'Questions list', %q{
Site visitor needs to have possibility to see all the questions
} do

  given(:user) { create(:user) }
  given(:questions) { create_list(:question, 2) }

  scenario 'Registered user is trying to access list with all the questions' do
    sign_in(user)
    list_questions(questions)
  end

  scenario 'Not registered user is trying to access list with all the questions' do
    list_questions(questions)
  end

  private

  def list_questions(questions)
    visit questions_path
    questions.each do |question|
      expect(page).to have_content question.title
    end
  end
end