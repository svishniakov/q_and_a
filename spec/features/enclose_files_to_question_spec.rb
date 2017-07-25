require_relative 'acceptance_helper'

feature 'Possibility to add an attachment to a question', js: true do
  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'User can add an attachment during question creation' do
    sign_in(user)
    click_on 'Ask question'

    fill_in 'Title', with: question.title
    fill_in 'Body', with: question.body

    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"

    click_on 'Upload file'
    within page.all('.attachment-fields')[1] do
      attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"
    end

    click_on 'Save question'

    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
    expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/2/rails_helper.rb'
  end
end
