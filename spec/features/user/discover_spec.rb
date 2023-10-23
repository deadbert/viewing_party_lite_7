# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Discover Page" do
  describe "When I visit '/users/:id/discover'" do
    before(:each) do
      @sally = User.create!(name: "Sally", email: "bettercallsal@gmail.com", password: "123456", password_confirmation: "123456")
      @alex = User.create!(name: "Alex", email: "alexthegreat@gmail.com", password: "123456", password_confirmation: "123456")
      @party1 = Party.create!(movie: 1, movie_title: "Bar Wars", party_date: "2023-10-11T14:43")
      UserParty.create!(user_id: @sally.id, party_id: @party1.id, host: true)
    end
  
    it "I should see a Button to 'Find Top Rated Movies'" do
      visit "/users/#{@sally.id}/discover"

      expect(page).to have_button('Find Top Rated Movies')
    end

    it "A text field to enter keyword(s) to search by movie title" do
      visit "/users/#{@sally.id}/discover"

      expect(page).to have_field(:search_movies)
    end

    it "A Button to Search by Movie Title" do
      visit "/users/#{@sally.id}/discover"

      expect(page).to have_button("Find Movies")
    end
  end
end
