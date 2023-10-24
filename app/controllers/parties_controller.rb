class PartiesController < ApplicationController
  before_action :require_login

  def new
    @user = User.find(params[:user_id])
    @movie = SearchFacade.new.find_movie(params[:id])
  end

  def create
    if params[:duration].to_i >= params[:movie_duration].to_i && params[:party_date] != ""
      if !params[:invitees].values.all?("0")
        create_parties
        redirect_to "/users/#{params[:user_id]}"
      else
        flash[:alert] = "Please invite people"
        redirect_to "/users/#{params[:user_id]}/movies/#{params[:id]}/new"
      end
    else
      flash[:alert] = "You Fool of a Took, you won't have time for the full movie, or maybe you didn't choose a day?"
      redirect_to "/users/#{params[:user_id]}/movies/#{params[:id]}/new"
    end
  end

  private

  def create_parties
    party = Party.create(movie: params[:id], movie_title: params[:title], party_date: params[:party_date], poster_path: params[:image])
    UserParty.create!(user_id: params[:user_id], party_id: party.id, host: true)
    params[:invitees].each do |key, value|
      if value == "1"
        UserParty.create!(user_id: key.to_i, party_id: party.id, host: false)
      end
    end
  end

  def require_login
    if session[:user_id] == nil
      flash[:error] = "You must log in to access this resource"
      redirect_to "/users/#{params[:user_id]}/movies/#{params[:movie_id]}"
    end
  end
end