require 'rails_helper'

RSpec.describe "Movie Results Page" do
  before(:each) do
    @sally = User.create!(name: "Sally", email: "bettercallsal@gmail.com", password: "123456", password_confirmation: "123456")
    @alex = User.create!(name: "Alex", email: "alexthegreat@gmail.com", password: "123456", password_confirmation: "123456")
    @party1 = Party.create!(movie: 1, movie_title: "Bar Wars", party_date: "2023-10-11T14:43")
    UserParty.create!(user_id: @sally.id, party_id: @party1.id, host: true)
  end

  describe "When I visit a user's discover page and I click on 'Find Top Rated Movies'" do
    it "Should display the top 20 movies with the highest ratings", :vcr do
      visit "/users/#{@sally.id}/discover"
      click_on "Find Top Rated Movies"

      expect(current_path).to eq("/users/#{@sally.id}/movies")

      expect(page).to have_content("The Godfather")
      expect(page).to have_content("Vote Average: 8.7")
      expect(page).to have_content("The Shawshank Redemption")
      expect(page).to have_content("Vote Average: 8.7")
      expect(page).to have_content("The Godfather Part II")
      expect(page).to have_content("Vote Average: 8.6")
      expect(page).to have_content("Schindler's List")
      expect(page).to have_content("Vote Average: 8.6")

    end
  end

  describe "When I visit a user's discover page, I fill out the search paramater and I click on 'Find Movies'", :vcr do
    it "Should display the top 20 movies with the closest keywords" do
      visit "/users/#{@sally.id}/discover"
      fill_in :search_movies, with: "Bar"
      click_on "Find Movies"

      expect(current_path).to eq("/users/#{@sally.id}/movies")
      expect(page).to have_content("Barbie")
      expect(page).to have_content("Vote Average: 7.233")
      expect(page).to have_content("El bar")
      expect(page).to have_content("Vote Average: 6.31")
      expect(page).to have_content("Barbarella")
      expect(page).to have_content("Vote Average: 6.0")
    end
  end
end