require 'rails_helper'

RSpec.describe Question, type: :model do
  context 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :body }
  end

  context 'relations' do
    it { should have_many(:answers).dependent(:destroy) }
    it { should belong_to :user }
  end
end
