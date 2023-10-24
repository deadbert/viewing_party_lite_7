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

    it "If I'm logged in I no longer see a Log In or create account link
  instead I see a Log Out button that when clicked logs out and routes to root path" do
    wayne = User.create!(name: "Wayne", email: "partytime@gmail.com", password: "123456", password_confirmation: "123456")

    visit login_path

    fill_in :email, with: "partytime@gmail.com"
    fill_in :password, with: "123456"
    click_on "Log In"

    visit "/"

    expect(page).to have_link("Log Out")
    expect(page).to_not have_link("Log In")

    click_on "Log Out"

    expect(page).to have_link("Log In")
    expect(page).to_not have_link("Log Out")
    end
  end
end