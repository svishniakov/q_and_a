require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'relations' do
    it { should belong_to :commentable }
    it { should belong_to :user }
  end
end
