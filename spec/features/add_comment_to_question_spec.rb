require_relative 'acceptance_helper'

feature 'Possibility to add comment to the question', js: true do
  given(:user) { create :user }
  given(:question) { create :question, user: user }
  given(:comment) { create :comment }

  context 'as logged in user' do
    scenario 'user can comment a question' do
      sign_in(user)
      visit question_path(question)

      click_on 'Add comment'
      fill_in 'comment[body]', with: comment.body
      click_on 'Post comment'
      expect(page).to have_content comment.body
    end
  end

  context 'an anonymous user' do
    scenario 'user can\'t comment a question' do
      visit question_path(question)
      expect(page).to_not have_link 'Add comment'
    end
  end
end