require 'spec_helper'

describe "Micropost pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:admin) }
  before { sign_in user }

  describe "event creation" do
    before { visit new_event_path }

  #  describe "with invalid information" do

  #    it "should not create a micropost" do
  #      expect { click_button "Create" }.not_to change(Event, :count)
  #    end

  #    describe "error messages" do
  #      before { click_button "Create" }
  #      it { should have_content('error') }
  #    end
  #  end

    describe "with valid information" do

      before { fill_in 'event_about', with: "Lorem ipsum" }
      before { fill_in 'event_title', with: "Brunchwork Event" }
      #before { select 'event_event_type', with: "brunchstory" }
      #before { fill_in 'event_date_time', with: Time.now }
      before { fill_in 'event_location', with: "New York, New York" }
      it "should create a event" do
        expect { click_button "Create" }.to change(Event, :count).by(1)
      end
    end
  end
end