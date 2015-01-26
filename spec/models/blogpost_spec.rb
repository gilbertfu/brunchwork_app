require 'spec_helper'

describe Blogpost do

  let(:user) { FactoryGirl.create(:user) }
  before do
    # This code is not idiomatically correct.
    @blogpost = Blogpost.new(content: "Lorem ipsum")
  end

  subject { @blogpost }

  it { should respond_to(:content) }
  it { should respond_to(:title) }
  it { should respond_to(:comments) }
  
  it { should be_valid }
  
  describe "when content is not present" do
    before { @blogpost.content = nil }
    it { should_not be_valid }
  end
end