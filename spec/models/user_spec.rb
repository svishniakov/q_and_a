require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
  end

  context 'relations' do
    it { should have_many(:questions).dependent(:destroy) }
    it { should have_many(:answers).dependent(:destroy) }
  end

  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:user_not_author) { create(:user) }

  describe '#author_of?' do
    it 'returns true if user is an author' do
      expect(user).to be_author_of(question)
    end

    it 'returns false if user is not an author' do
      expect(user_not_author).to_not be_author_of(question)
    end
  end
end
