require 'spec_helper'

describe Event do

  let(:user) { FactoryGirl.create(:user) }
  before do
    # This code is not idiomatically correct.
    @event = Event.new(about: "Lorem ipsum", title: "Default Title", 
                       event_type:"brunchstory", date_time:Time.now,
                       location: "New York")
  end

  subject { @event }

  it { should respond_to(:about) }
  it { should respond_to(:title) }
  it { should respond_to(:event_type) }
  it { should respond_to(:date_time) }
  it { should respond_to(:location) }
  it { should respond_to(:users) }
  
  
  it { should be_valid }

  describe "when title is not present" do
    before { @event.title = nil }
    it { should_not be_valid }
  end
  
  describe "when date_time is not present" do
    before { @event.date_time = nil }
    it { should_not be_valid }
  end
  
  describe "when date_time is not present" do
    before { @event.date_time = nil }
    it { should_not be_valid }
  end
end