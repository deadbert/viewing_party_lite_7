# As a registered user
# When I visit the landing page `/`
# I see a link for "Log In"
# When I click on "Log In"
# I'm taken to a Log In page ('/login') where I can input my unique email and password.
# When I enter my unique email and correct password 
# I'm taken to my dashboard page
require 'rails_helper'

RSpec.describe "User Login" do
  describe "As a registered user" do
    describe "When I visit the log in page" do
      it "I can fill out the form to log in, and be taken to the dashboard" do
        wayne = User.create!(name: "Wayne", email: "partytime@gmail.com", password: "123456", password_confirmation: "123456")

        visit login_path

        fill_in :email, with: "partytime@gmail.com"
        fill_in :password, with: "123456"
        click_on "Log In"

        expect(current_path).to eq("/users/#{wayne.id}")
      end

      it "Gives me an error if I fill out the wrong credentials" do
        wayne = User.create!(name: "Wayne", email: "partytime@gmail.com", password: "123456", password_confirmation: "123456")

        visit login_path

        fill_in :email, with: "partytime@gmail.com"
        fill_in :password, with: "abcdefg"
        click_on "Log In"

        expect(current_path).to eq(login_path)
        expect(page).to have_content("Incorrect email or Password")
      end
    end
  end
end