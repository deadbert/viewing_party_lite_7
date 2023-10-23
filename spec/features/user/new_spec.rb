require 'rails_helper'

RSpec.describe 'Register Page', type: :feature do
  describe "As a visitor when I visit '/register'" do
    it "I should see a form to register as a new user" do
      visit register_path

      expect(page).to have_content("Register as a New User")
      expect(page).to have_content("Name:")
      expect(page).to have_content("Email:")
      expect(page).to have_content("Password:")
      expect(page).to have_content("Confirm Password:")
      expect(page).to have_button("Register")
      
      fill_in "Name:", with: "Wayne"
      fill_in "Email:", with: "partytime@gmail.com"
      fill_in "Password:", with: "123456"
      fill_in "Confirm Password:", with: "123456"
      click_on "Register"

      expect(page).to have_content("Wayne's Dashboard")
    end

    it "won't let you register with existing email" do
      User.create!(name: "Wayne", email: "partytime@gmail.com", password: "123456", password_confirmation: "123456")

      visit register_path

      fill_in "Name:", with: "Dwayne"
      fill_in "Email:", with: "partytime@gmail.com"
      fill_in "Password:", with: "123456"
      fill_in "Confirm Password:", with: "123456"
      click_on "Register"

      expect(page).to have_content("Email has already been taken")
    end

    it "won't let you register if password and password_confirmation do not match" do
    
      visit register_path

      fill_in "Name:", with: "Dwayne"
      fill_in "Email:", with: "partytime@gmail.com"
      fill_in "Password:", with: "123456"
      fill_in "Confirm Password:", with: "abcdefg"
      click_on "Register"

      expect(page).to have_content("Password confirmation doesn't match Password")
    end
  end
end