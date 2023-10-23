require 'rails_helper'

RSpec.describe Party, type: :model do
  before(:each) do
    @sally = User.create!(name: "Sally", email: "bettercallsal@gmail.com", password: "123456", password_confirmation: "123456")
    @alex = User.create!(name: "Alex", email: "alexthegreat@gmail.com", password: "123456", password_confirmation: "123456")
    @party1 = Party.create!(movie: 1, movie_title: "Bar Wars", party_date: "2023-10-11T14:43")
    UserParty.create!(user_id: @sally.id, party_id: @party1.id, host: true)
    UserParty.create!(user_id: @alex.id, party_id: @party1.id, host: false)
  end

  describe "validations" do
    it { should validate_presence_of :movie }
  end

  describe "relationships" do
    it { should have_many :user_parties }
    it { should have_many(:users).through(:user_parties) }
  end

  describe "instance methods" do
    describe "formated_time" do
      it "returns party time in the correct format" do
        expect(@party1.formated_time).to eq("Wednesday, October 11, 2023, 02:43 pm")
      end
    end

    describe "host?" do
      it "returns 'Hosting' or 'Invited' if host is true/false" do
        expect(@party1.host?(@sally)).to eq("Hosting")
        expect(@party1.host?(@alex)).to eq("Invited")
      end
    end

    describe "attendees" do
      it "returns the name of users attending a specific party who are not the host" do
        expect(@party1.attendees).to be_an Array
      end
    end
  end
end