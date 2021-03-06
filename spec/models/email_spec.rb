require 'spec_helper'

describe Email do

  before { @email = Email.new(email: "user@example.com") }

  subject { @email }

  it { should respond_to(:email) }
  it { should respond_to(:unsubscribe_hash) }
  
  it { should be_valid }

  describe "when email is not present" do
    before { @email.email = " " }
    it { should_not be_valid }
  end
  
  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @email.email = invalid_address
        expect(@email).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @email.email = valid_address
        expect(@email).to be_valid
      end
    end
  end
  
  describe "when email address is already taken" do
    before do
      user_with_same_email = @email.dup
      user_with_same_email.save
    end

    it { should_not be_valid }
  end
  
  describe "unsubscribe hash" do
    before { @email.save }
    its(:unsubscribe_hash) { should_not be_blank }
  end
  
end