require 'rails_helper'

RSpec.describe "Create new Viewing Party page", type: :feature do
  before(:each) do
    @sally = User.create!(name: "Sally", email: "bettercallsal@gmail.com", password: "123456", password_confirmation: "123456")
    @alex = User.create!(name: "Alex", email: "alexthegreat@gmail.com", password: "123456", password_confirmation: "123456")
    @party1 = Party.create!(movie: 1, movie_title: "Bar Wars", party_date: "2023-10-11T14:43")
    UserParty.create!(user_id: @sally.id, party_id: @party1.id, host: true)
  end
  describe "As a visitor", :vcr do
    describe "When I visit the create new party page" do
      it "I should see the name of the movie title and a form
      with the fields duration of party, data of party, start time
      checkboxes next to users in the system, button to submit" do
        visit login_path
        fill_in :email, with: @sally.email
        fill_in :password, with: "123456"
        click_on "Log In"

        visit "/users/#{@sally.id}/movies/238/new"

        within(".party_form") do
          expect(page).to have_content("Movie Title: The Godfather")
          expect(page).to have_field :duration
          expect(page).to have_field :party_date
          expect(page).to have_button "Create Party"
          expect(page).to have_unchecked_field "[invitees][#{@alex.id}]"
        end
      end

      it "When I click submit a new party is created, and I am redirected
      back to the users dashboard where I see the new party" do
        visit login_path
        fill_in :email, with: @sally.email
        fill_in :password, with: "123456"
        click_on "Log In"
        visit "/users/#{@sally.id}/movies/238/new"

        # Sad Path Test
        within(".party_form") do
          fill_in :duration, with: 5
          fill_in :party_date, with: DateTime.current
          expect(page).to have_button "Create Party"
          page.check("[invitees][#{@alex.id}]")
          click_on "Create Party"
        end

        expect(page).to have_content("You Fool of a Took, you won't have time for the full movie, or maybe you didn't choose a day?")

        within(".party_form") do
          fill_in :duration, with: 175
          fill_in :party_date, with: DateTime.current
          expect(page).to have_button "Create Party"
          click_on "Create Party"
        end

        expect(page).to have_content("Please invite people")

        # Happy Path
        within(".party_form") do
          fill_in :duration, with: 200
          fill_in :party_date, with: DateTime.current
          expect(page).to have_button "Create Party"
          page.check("[invitees][#{@alex.id}]")
          click_on "Create Party"
        end
        
        expect(page).to have_content("The Godfather")
        expect(page).to have_content(DateTime.current.strftime("%A, %B %-d, %Y, %I:%M %P"))
        expect(page).to have_content("Hosting")

        within(".#{@alex.name}") do
         expect(page).to have_content("Alex")
        end
      end
    end
  end
end