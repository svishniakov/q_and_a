require 'rails_helper'

feature 'Access question page with answers' do
  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given(:answer) { create(:answer, question: question, user: user) }

  context 'As an anonymous' do
    scenario 'user can access question page to see the answers' do
      list_answers
    end
  end

  context 'As registered user' do
    scenario 'user can access question page to see the answers' do
      sign_in(user)
      list_answers
    end
  end

  private

  def list_answers
    visit question_path(question)
    question.answers.each do |answer|
      expect(page).to have_content answer.body
    end
  end
end