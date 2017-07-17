require_relative 'acceptance_helper'

feature 'Possibility to add an attachment to an answer' do
  given(:user) { create(:user) }
  given!(:question) { create(:question) }

  context 'as a registered user' do
    before do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'User can add attachments during answer creation', js: true do
      fill_in 'answer_body', with: 'My answer with attachments!'

      attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"

      click_on 'Upload file'
      within page.all('.attachment-fields')[1] do
        attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"
      end

      click_on 'Post answer'

      within '#answers' do
        expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
        expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/2/rails_helper.rb'
      end
    end
  end
end