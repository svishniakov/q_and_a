require 'rails_helper'
require_relative '../support/votable'

RSpec.describe Question, type: :model do
  context 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :body }
  end

  context 'relations' do
    it { should have_many(:answers).dependent(:destroy) }
    it { should belong_to :user }
    it { should have_many :attachments }
  end

  context 'attributes' do
    it { should accept_nested_attributes_for :attachments }
  end

  context 'methods' do
    it_behaves_like 'votable'
  end
end
