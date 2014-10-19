require 'spec_helper'

describe "StaticPages" do
  describe "Home page" do
    it "should have content 'Brunchwork'" do
      visit root_path
      expect(page).to have_content('BrunchWork')
    end
    
    it "should have title 'Home'" do
      visit root_path
      expect(page).to have_title('BrunchWork')
      expect(page).not_to have_title('| Home')
    end
    
  end
  
  describe "Help page" do
    it "should have content 'Help'" do
      visit help_path
      expect(page).to have_content('Help')
    end
    it "should have title 'Help'" do
      visit help_path
      expect(page).to have_title('BrunchWork | Help')
    end
  end
  
  describe "About page" do
    it "should have the content 'About Us'" do
      visit about_path
      expect(page).to have_content('About Us')
    end
    
    it "should have title 'About Us'" do
      visit about_path
      expect(page).to have_title('BrunchWork | About Us')
    end
  end
  
  describe "Contact page" do
    it "should have the content 'Contact'" do
      visit contact_path
      expect(page).to have_content('Contact')
    end
    
    it "should have title 'Contact'" do
      visit contact_path
      expect(page).to have_title('BrunchWork | Contact')
    end
  end
end
