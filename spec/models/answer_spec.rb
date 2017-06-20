require 'rails_helper'

RSpec.describe Answer, type: :model do
  context 'validations' do
    it { should validate_presence_of :body }
  end

  context 'relations' do
    it { should belong_to :question }
    it { should belong_to :user }
  end
end
