require 'rails_helper'

RSpec.describe Questions::CommentsController, type: :controller do
  it_behaves_like 'commented'
end