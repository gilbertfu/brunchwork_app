require 'spec_helper'

describe User do

  before { @user = User.new(name: "Example User", email: "user@example.com", school: "UCLA", work_position: "Free Code Monkey", company: "Brunchwork") }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:school) }
  it { should respond_to(:work_position) }
  it { should respond_to(:company) }
end