require 'rails_helper'

RSpec.describe 'User Show Page', type: :feature do
  before(:each) do
    @sally = User.create!(name: "Sally", email: "bettercallsal@gmail.com", password: "123456", password_confirmation: "123456")
    @alex = User.create!(name: "Alex", email: "alexthegreat@gmail.com", password: "123456", password_confirmation: "123456")
    @party1 = Party.create!(movie: 1, movie_title: "Bar Wars", party_date: "2023-10-11T14:43")
    UserParty.create!(user_id: @sally.id, party_id: @party1.id, host: true)
  end

  describe "As a user when I visit /users/:id" do
    it "I see '<user name>'s Dashboard" do
      visit user_path(@sally)

      expect(page).to have_content("Sally's Dashboard")
    end

    it "I see a button to discover movies" do
      visit user_path(@sally)

      expect(page).to have_button("Discover Movies")
    end

    it "I see a section that lists viewing parties" do
      visit user_path(@sally)

      within(".viewing_parties") do
        expect(page).to have_content(@party1.movie)
        expect(page).to have_content(@party1.movie_title)
        expect(page).to have_content(@party1.formated_time)
        expect(page).to have_content("Hosting")
      end
    end

    describe "When I click 'Discover Movies' button" do
      it "I am redirected to discover page '/users/:id/discover'" do
        visit user_path(@sally)

        click_on "Discover Movies"
        expect(current_path).to eq("#{user_path(@sally)}/discover")
      end
    end
  end
end