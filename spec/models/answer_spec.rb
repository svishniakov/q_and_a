require 'rails_helper'

RSpec.describe Answer, type: :model do
  context 'validations' do
    it { should validate_presence_of :body }
  end

  context 'relations' do
    it { should belong_to :question }
  end
end
