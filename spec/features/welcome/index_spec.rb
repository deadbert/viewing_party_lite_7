require 'rails_helper'

RSpec.describe "Welcome Page", type: :feature do
  describe "As a visitor when I visit '/'" do
    it "I should see the title of the application" do 
      visit "/"

      expect(page).to have_content("Viewing Party")
    end
    
    it "A button to create a new user" do 
      visit "/"

      expect(page).to have_button("Create a New User")
    end
    
    it "A list of existing users, which links to a user dashboard" do 
      sally = User.create!(name: "Sally", email: "bettercallsal@gmail.com", password: "123456", password_confirmation: "123456")
      alex = User.create!(name: "Alex", email: "alexthegreat@gmail.com", password: "123456", password_confirmation: "123456")

      visit "/"

      expect(page).to have_content("Existing Users")
      expect(page).to have_content(sally.email)
      expect(page).to have_content(alex.email)
    end
    
    it "A link back to the welcome page" do 
      visit "/"

      expect(page).to have_link("Home")

      click_on "Home"
      expect(current_path).to eq("/")
    end
  end
end