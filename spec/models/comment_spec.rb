require 'spec_helper'

describe Comment do

  let(:user) { FactoryGirl.create(:user) }
  before do
    # This code is not idiomatically correct.
    @comment = Comment.new(content: "Lorem ipsum", blogpost_id: 1, user_id: user.id)
  end

  subject { @comment }

  it { should respond_to(:content) }
  it { should respond_to(:blogpost_id) }
  it { should respond_to(:user_id) }
end