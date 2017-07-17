require_relative 'acceptance_helper'

feature 'Possibility to add an attachment to a question' do
  given(:user) { create(:user) }

  context 'as a registered user' do
    let(:question) { create(:question) }

    before do
      sign_in(user)
      click_on 'Ask question'
    end

    scenario 'User can add an attachment during question creation' do
      fill_in 'Title', with: question.title
      fill_in 'Body', with: question.body
      attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
      click_on 'Save question'

      expect(page).to have_content 'spec_helper.rb'
    end
  end
end