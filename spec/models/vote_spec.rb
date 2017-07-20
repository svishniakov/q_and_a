require 'rails_helper'

RSpec.describe Vote, type: :model do
  context 'relations' do
    it { should belong_to :votable }
    it { should belong_to :user }
  end

  context 'validations' do
    it { should validate_uniqueness_of(:user_id).scoped_to(%i[votable_type votable_id]) }
  end
end
