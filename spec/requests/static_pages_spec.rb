require 'spec_helper'

describe "Static pages" do
  
  let(:static_title) { "Ruby on Rails Tutorial Sample App"}
  
  describe "Home page" do

    it "should have the content 'Sample App'" do
      visit '/static_pages/home'
      expect(page).to have_content('Sample App')
    end
    
    it "should have the title" do
          visit '/static_pages/home'
          expect(page).to have_title("#{static_title}")
    end
    
    it "should not have a custom page title" do
      visit '/static_pages/home'
      expect(page).not_to have_title('| Home')
    end
    
  end
  
  describe "Help page" do

      it "should have the content 'Help'" do
        visit '/static_pages/help'
        expect(page).to have_content('Help')
      end
      
      it "should have the title 'Help'" do
            visit '/static_pages/help'
            expect(page).to have_title("#{static_title} | Help")
      end
    end
    
  describe "About" do
      
      it "should have the content 'About'" do
        visit '/static_pages/about'
        expect(page).to have_content('About')
      end
      
      it "should have the title 'About'" do
            visit '/static_pages/about'
            expect(page).to have_title("#{static_title} | About")
      end
  end
  
  describe "Contact" do
    
    it "should have the content 'Contact'" do
      visit '/static_pages/contact'
      expect(page).to have_content('Contact')
    end
    it "should have the title 'Contact'" do
      visit '/static_pages/contact'
      expect(page).to have_title("#{static_title} | Contact")
    end
    
  end
  
end