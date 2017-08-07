require 'rails_helper'

RSpec.describe Answers::CommentsController, type: :controller do
  it_behaves_like 'commented'
end