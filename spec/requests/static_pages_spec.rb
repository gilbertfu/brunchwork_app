require 'spec_helper'

describe "StaticPages" do
  describe "Home page" do
    it "should have content 'Brunchwork'" do
      visit root_path
      expect(page).to have_content('Introducing the power brunch')
    end
    
    it "should have title 'Home'" do
      visit root_path
      expect(page).to have_title('brunchwork')
      expect(page).not_to have_title('| Home')
    end
    
    describe "signup" do

      before { visit root_path }
  
      let(:submit) { "Join" }
  
      describe "with invalid information" do
        it "should not create an email" do
          expect { click_button submit }.not_to change(Email, :count)
        end
      end
  
      describe "with valid information" do
        before do
          fill_in "email_email",        with: "user@example.com"
        end
  
        it "should create an email" do
          expect { click_button submit }.to change(Email, :count).by(1)
        end
      end
    end
  end
  
end
