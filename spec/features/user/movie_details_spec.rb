require 'rails_helper'

# frozen_string_literal: true

RSpec.describe "Movie Details Page" do
  describe "When I visit a movie's detail page" do
    before(:each) do
      @sally = User.create!(name: "Sally", email: "bettercallsal@gmail.com", password: "123456", password_confirmation: "123456")
      @alex = User.create!(name: "Alex", email: "alexthegreat@gmail.com", password: "123456", password_confirmation: "123456")
      @party1 = Party.create!(movie: 1, movie_title: "Bar Wars", party_date: "2023-10-11T14:43")
      UserParty.create!(user_id: @sally.id, party_id: @party1.id, host: true)
    end

    describe "Details Page", :vcr do
      it "I should see a button to create a viewing party, and a button to go back to the discover page" do
        visit "/users/#{@sally.id}/movies/238" # need to find a way to access the id of movies without hardcoding them

        expect(page).to have_button("Create a Viewing Party")
        expect(page).to have_button("Discover Page")
      end

      it "I should see details about the movie" do
        visit "/users/#{@sally.id}/movies/238"

        expect(page).to have_content("The Godfather") 
        expect(page).to have_content("Average Rating: 8.7")
        expect(page).to have_content("Runtime: 175 minutes")
        expect(page).to have_content("Genre(s): Drama, Crime")
        expect(page).to have_content("Spanning the years 1945 to 1955")
        expect(page).to have_content("Marlon Brando as Don Vito Corleone")
        expect(page).to have_content("Al Pacino as Michael Corleone")
        expect(page).to have_content("5 Reviews") 
        expect(page).to have_content("Username: futuretv") 
        expect(page).to have_content("The Godfather Review by Al Carlson") 
      end
    end
  end
end
